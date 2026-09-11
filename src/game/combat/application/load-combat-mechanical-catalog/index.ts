import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbBattleMasterManeuver } from '@entities/subclass-feature/phb-battle-master-maneuver.entity';
import { PhbBeastborneAspectBenefit } from '@entities/subclass-feature/phb-beastborne-aspect-benefit.entity';
import { PhbClassPanelAction } from '@entities/class/phb-class-panel-action.entity';
import { PhbCunningStrikeEffect } from '@entities/subclass-feature/phb-cunning-strike-effect.entity';
import { PhbDungeoneerSlayerType } from '@entities/subclass-feature/phb-dungeoneer-slayer-type.entity';
import { PhbGunslingerManeuver } from '@entities/subclass-feature/phb-gunslinger-maneuver.entity';
import { PhbOptionValue } from '@entities/reference/phb-option.entity';
import { PhbPersonaMask } from '@entities/subclass-feature/phb-persona-mask.entity';
import { PhbSubclassPrecautionSpell } from '@entities/subclass-feature/phb-subclass-precaution-spell.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import { PhbSubclassTableAction } from '@entities/subclass-feature/phb-subclass-table-action.entity';
import { VPhbClassEconomyAction } from '@entities/views/v-phb-class-economy-action.entity';
import { LoadEffectCatalog } from '@game/effects';
import { BLOOD_HOUND_SUBCLASS_SLUG } from '../../domain/fighter';
import {
  STRIKE_OPTION_REQUIRES_KEY,
  buildStrikeOptionsFromEffects,
} from '../../domain/build-strike-options-from-effects';
import { mapCombatMechanicalCatalog } from './map-rows';
import type { CombatMechanicalCatalog } from './types';
import { loadAllFeatureSchedules } from '../../infrastructure/feature-schedule.queries';

export type {
  CombatMechanicalCatalog,
  PersonaMaskCatalogEntry,
} from './types';

@Injectable()
export class LoadCombatMechanicalCatalog {
  /** TTL do cache em memória (warm instance / vários loads no mesmo request). */
  static readonly CACHE_TTL_MS = 60_000;

  private cache: CombatMechanicalCatalog | null = null;
  private cacheAtMs = 0;
  private inflight: Promise<CombatMechanicalCatalog> | null = null;

  constructor(
    @InjectRepository(PhbGunslingerManeuver)
    private readonly gunslingerRepo: Repository<PhbGunslingerManeuver>,
    @InjectRepository(PhbBattleMasterManeuver)
    private readonly battleMasterRepo: Repository<PhbBattleMasterManeuver>,
    @InjectRepository(PhbCunningStrikeEffect)
    private readonly cunningRepo: Repository<PhbCunningStrikeEffect>,
    @InjectRepository(PhbSubclassTableAction)
    private readonly tableActionRepo: Repository<PhbSubclassTableAction>,
    @InjectRepository(PhbPersonaMask)
    private readonly personaMaskRepo: Repository<PhbPersonaMask>,
    @InjectRepository(PhbBeastborneAspectBenefit)
    private readonly beastborneRepo: Repository<PhbBeastborneAspectBenefit>,
    @InjectRepository(PhbDungeoneerSlayerType)
    private readonly slayerRepo: Repository<PhbDungeoneerSlayerType>,
    @InjectRepository(PhbSubclassPrecautionSpell)
    private readonly precautionRepo: Repository<PhbSubclassPrecautionSpell>,
    @InjectRepository(VPhbClassEconomyAction)
    private readonly economyRepo: Repository<VPhbClassEconomyAction>,
    @InjectRepository(PhbClassPanelAction)
    private readonly panelRepo: Repository<PhbClassPanelAction>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValueRepo: Repository<PhbOptionValue>,
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRepo: Repository<PhbSubclassRef>,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly dataSource: DataSource,
  ) {}

  async load(): Promise<CombatMechanicalCatalog> {
    const now = Date.now();
    if (
      this.cache &&
      now - this.cacheAtMs < LoadCombatMechanicalCatalog.CACHE_TTL_MS
    ) {
      return this.cache;
    }
    if (this.inflight) return this.inflight;

    this.inflight = this.loadFromDb()
      .then((catalog) => {
        this.cache = catalog;
        this.cacheAtMs = Date.now();
        this.inflight = null;
        return catalog;
      })
      .catch((error: unknown) => {
        this.inflight = null;
        throw error;
      });

    return this.inflight;
  }

  /** Invalida cache (testes / após reseed na mesma instância). */
  clearCache(): void {
    this.cache = null;
    this.cacheAtMs = 0;
    this.inflight = null;
  }

  private async loadFromDb(): Promise<CombatMechanicalCatalog> {
    const [
      gunslingerRows,
      battleMasterRows,
      cunningRows,
      tableActionRows,
      personaRows,
      beastborneRows,
      slayerRows,
      precautionRows,
      economyRows,
      panelRows,
      strikeOptions,
      featureGatesBySubclassSlug,
      featureSchedules,
    ] = await Promise.all([
      this.gunslingerRepo.find({ relations: ['subclass'] }),
      this.battleMasterRepo.find(),
      this.cunningRepo.find({ relations: ['subclass'] }),
      this.tableActionRepo.find({ relations: ['subclass'] }),
      this.personaMaskRepo.find({ relations: ['subclass'] }),
      this.beastborneRepo.find(),
      this.slayerRepo.find({ order: { sortOrder: 'ASC' } }),
      this.precautionRepo.find({
        where: { subclass: { slug: 'dungeoneer' } },
        relations: ['subclass', 'spell'],
      }),
      this.economyRepo.find({ order: { sortOrder: 'ASC' } }),
      this.panelRepo.find({
        relations: ['klass', 'subclass'],
        order: { sortOrder: 'ASC' },
      }),
      this.loadStrikeOptions(),
      this.loadFeatureGates(),
      loadAllFeatureSchedules(this.dataSource),
    ]);

    return mapCombatMechanicalCatalog({
      gunslingerRows,
      battleMasterRows,
      cunningRows,
      strikeOptions,
      tableActionRows,
      personaRows,
      beastborneRows,
      slayerRows,
      precautionRows,
      economyRows,
      panelRows,
      featureGatesBySubclassSlug,
      featureSchedulesByClassSlug: featureSchedules.byClassSlug,
      featureSchedulesBySubclassSlug: featureSchedules.bySubclassSlug,
    });
  }

  private async loadFeatureGates(): Promise<
    ReadonlyMap<string, ReadonlyMap<string, number>>
  > {
    const raw: { slug: string; gate_key: string; unlock_level: number }[] =
      await this.dataSource.query(
        `
        SELECT s.slug, g.gate_key, g.unlock_level
        FROM rpg.phb_subclass_feature_gate g
        JOIN rpg.phb_subclass s ON s.id = g.subclass_id
        `,
      );
    const bySubclass = new Map<string, Map<string, number>>();
    for (const row of raw) {
      let gates = bySubclass.get(row.slug);
      if (!gates) {
        gates = new Map();
        bySubclass.set(row.slug, gates);
      }
      gates.set(row.gate_key, Number(row.unlock_level));
    }
    return bySubclass;
  }

  private async loadStrikeOptions() {
    const effects = await this.effectCatalog.load({
      ownerKind: 'subclass',
      ownerSlugs: [BLOOD_HOUND_SUBCLASS_SLUG],
    });
    const strikeEffects = effects.filter(
      (e) => e.requiresOptionKey === STRIKE_OPTION_REQUIRES_KEY,
    );
    const labels = await this.loadStrikeOptionLabels();
    return buildStrikeOptionsFromEffects({
      effects: strikeEffects,
      optionLabels: labels,
    });
  }

  private async loadStrikeOptionLabels(): Promise<Map<string, string>> {
    const subclass = await this.subclassRepo.findOne({
      where: { slug: BLOOD_HOUND_SUBCLASS_SLUG },
    });
    if (!subclass) return new Map();
    const rows = await this.optionValueRepo.find({
      where: {
        scope: 'subclass',
        ownerId: subclass.id,
        optionKey: 'bloodStrike1',
      },
    });
    return new Map(rows.map((row) => [row.valueId, row.label]));
  }
}
