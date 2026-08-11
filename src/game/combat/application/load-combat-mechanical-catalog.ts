import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBattleMasterManeuver } from '@entities/views/v-phb-battle-master-maneuver.entity';
import { VPhbBeastborneAspectBenefit } from '@entities/views/v-phb-beastborne-aspect-benefit.entity';
import { VPhbClassEconomyAction } from '@entities/views/v-phb-class-economy-action.entity';
import { VPhbClassPanelAction } from '@entities/views/v-phb-class-panel-action.entity';
import { VPhbCunningStrikeEffect } from '@entities/views/v-phb-cunning-strike-effect.entity';
import { VPhbDungeoneerSlayerType } from '@entities/views/v-phb-dungeoneer-slayer-type.entity';
import { VPhbGunslingerManeuver } from '@entities/views/v-phb-gunslinger-maneuver.entity';
import { VPhbPersonaMask } from '@entities/views/v-phb-persona-mask.entity';
import { VPhbSubclassPrecautionSpell } from '@entities/views/v-phb-subclass-precaution-spell.entity';
import { VPhbSubclassTableAction } from '@entities/views/v-phb-subclass-table-action.entity';
import type { BattleMasterManeuver } from '../domain/fighter';
import type {
  ActionEconomyBucket,
  ClassEconomyActionRecord,
  ClassPanelActionRecord,
  PanelActionSection,
} from '../domain/class-action-ui-catalog';
import type { PrecautionSpell } from '../domain/fighter';
import type { GunslingerManeuver, ManeuverEffectKind } from '../domain/gunslinger';
import type { CunningStrikeEffect } from '../domain/rogue/types';
import type { SubclassTableAction } from '../domain/catalog';

export type PersonaMaskCatalogEntry = {
  slug: string;
  name: string;
};

export type CombatMechanicalCatalog = {
  gunslingerManeuvers: GunslingerManeuver[];
  battleMasterManeuvers: BattleMasterManeuver[];
  cunningStrikeEffects: CunningStrikeEffect[];
  tableActions: SubclassTableAction[];
  personaMasks: PersonaMaskCatalogEntry[];
  personaMaskSlugs: string[];
  beastborneAspectBenefits: { level: number; note: string }[];
  dungeoneerSlayerLabels: string[];
  precautionSpells: PrecautionSpell[];
  economyActions: ClassEconomyActionRecord[];
  panelActions: ClassPanelActionRecord[];
};

const ECONOMY_BUCKETS = new Set<ActionEconomyBucket>([
  'action',
  'bonus',
  'reaction',
  'free',
]);

const PANEL_SECTIONS = new Set<PanelActionSection>([
  'base',
  'subclass',
  'metamagic',
  'channel',
]);

function asEconomyBucket(value: string): ActionEconomyBucket {
  return ECONOMY_BUCKETS.has(value as ActionEconomyBucket)
    ? (value as ActionEconomyBucket)
    : 'free';
}

function asPanelSection(value: string): PanelActionSection {
  return PANEL_SECTIONS.has(value as PanelActionSection)
    ? (value as PanelActionSection)
    : 'base';
}

/** Prefere o texto jogável mais completo entre C009 e C010 title. */
function pickPlayableText(
  ...candidates: Array<string | null | undefined>
): string | undefined {
  let best: string | undefined;
  for (const candidate of candidates) {
    const text = candidate?.trim();
    if (!text) continue;
    if (!best || text.length > best.length) best = text;
  }
  return best;
}

@Injectable()
export class LoadCombatMechanicalCatalog {
  /** TTL do cache em memória (warm instance / vários loads no mesmo request). */
  static readonly CACHE_TTL_MS = 60_000;

  private cache: CombatMechanicalCatalog | null = null;
  private cacheAtMs = 0;
  private inflight: Promise<CombatMechanicalCatalog> | null = null;

  constructor(
    @InjectRepository(VPhbGunslingerManeuver)
    private readonly gunslingerRepo: Repository<VPhbGunslingerManeuver>,
    @InjectRepository(VPhbBattleMasterManeuver)
    private readonly battleMasterRepo: Repository<VPhbBattleMasterManeuver>,
    @InjectRepository(VPhbCunningStrikeEffect)
    private readonly cunningRepo: Repository<VPhbCunningStrikeEffect>,
    @InjectRepository(VPhbSubclassTableAction)
    private readonly tableActionRepo: Repository<VPhbSubclassTableAction>,
    @InjectRepository(VPhbPersonaMask)
    private readonly personaMaskRepo: Repository<VPhbPersonaMask>,
    @InjectRepository(VPhbBeastborneAspectBenefit)
    private readonly beastborneRepo: Repository<VPhbBeastborneAspectBenefit>,
    @InjectRepository(VPhbDungeoneerSlayerType)
    private readonly slayerRepo: Repository<VPhbDungeoneerSlayerType>,
    @InjectRepository(VPhbSubclassPrecautionSpell)
    private readonly precautionRepo: Repository<VPhbSubclassPrecautionSpell>,
    @InjectRepository(VPhbClassEconomyAction)
    private readonly economyRepo: Repository<VPhbClassEconomyAction>,
    @InjectRepository(VPhbClassPanelAction)
    private readonly panelRepo: Repository<VPhbClassPanelAction>,
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
    ] = await Promise.all([
      this.gunslingerRepo.find(),
      this.battleMasterRepo.find(),
      this.cunningRepo.find(),
      this.tableActionRepo.find(),
      this.personaMaskRepo.find(),
      this.beastborneRepo.find(),
      this.slayerRepo.find({ order: { sortOrder: 'ASC' } }),
      this.precautionRepo.find({
        where: { subclassSlug: 'dungeoneer' },
      }),
      this.economyRepo.find({ order: { sortOrder: 'ASC' } }),
      this.panelRepo.find({ order: { sortOrder: 'ASC' } }),
    ]);

    return {
      gunslingerManeuvers: gunslingerRows.map((row) => ({
        slug: row.slug,
        name: row.name,
        description: row.description,
        effectKind: row.effectKind as ManeuverEffectKind,
        riskCost: Number(row.riskCost),
        fromLevel: Number(row.fromLevel),
        subclassSlug: row.subclassSlug ?? undefined,
      })),
      battleMasterManeuvers: battleMasterRows.map((row) => ({
        slug: row.slug,
        name: row.name,
        description: row.description,
        timing: row.timing as BattleMasterManeuver['timing'],
        addsToDamage: Boolean(row.addsToDamage),
        addsToAttack: Boolean(row.addsToAttack),
      })),
      cunningStrikeEffects: cunningRows.map((row) => ({
        slug: row.slug as CunningStrikeEffect['slug'],
        name: row.name,
        cost: Number(row.cost),
        unlockLevel: Number(row.unlockLevel),
        saveAbility:
          row.saveAbility === 'constitution' || row.saveAbility === 'dexterity'
            ? row.saveAbility
            : undefined,
        subclassSlug:
          row.subclassSlug === 'thief' ||
          row.subclassSlug === 'arachnoid-stalker'
            ? row.subclassSlug
            : undefined,
        note: row.note,
      })),
      tableActions: tableActionRows.map((row) => ({
        subclassSlug: row.subclassSlug,
        slug: row.slug,
        name: row.name,
        unlockLevel: Number(row.unlockLevel),
        freeResourceSlug: row.freeResourceSlug ?? undefined,
        alwaysSpendsPool: Boolean(row.alwaysSpendsPool),
        rollsPoolDie: Boolean(row.rollsPoolDie),
        spendsOnlyOnSuccess: Boolean(row.spendsOnlyOnSuccess),
        alwaysPoolCost:
          row.alwaysPoolCost == null ? undefined : Number(row.alwaysPoolCost),
        repeatPoolCost:
          row.repeatPoolCost == null ? undefined : Number(row.repeatPoolCost),
      })),
      personaMasks: personaRows.map((row) => ({
        slug: row.slug,
        name: row.name,
      })),
      personaMaskSlugs: personaRows.map((row) => row.slug),
      beastborneAspectBenefits: beastborneRows.map((row) => ({
        level: Number(row.aspectLevel),
        note: row.note,
      })),
      dungeoneerSlayerLabels: slayerRows.map((row) => row.label),
      precautionSpells: precautionRows.map((row) => ({
        slug: row.spellSlug,
        name: row.spellName,
      })),
      economyActions: economyRows.map((row) => ({
        id: row.actionId,
        name: row.name,
        economy: asEconomyBucket(row.economy),
        classSlug: row.classSlug ?? undefined,
        minLevel: Number(row.unlockLevel),
        subclassSlug: row.subclassSlug ?? undefined,
        speciesSlug: row.speciesSlug ?? undefined,
        featSlug: row.featSlug ?? undefined,
        itemSlug: row.itemSlug ?? undefined,
        requiresOptionKey: row.requiresOptionKey ?? undefined,
        requiresOptionValue: row.requiresOptionValue ?? undefined,
        resourceSlug: row.resourceSlug ?? undefined,
        freeResourceSlug: row.freeResourceSlug ?? undefined,
        alwaysSpendsResource: Boolean(row.alwaysSpendsResource) || undefined,
        summary: row.summary ?? undefined,
        description: row.description ?? undefined,
        tableAction: row.tableAction ?? undefined,
        spendAmount:
          row.spendAmount == null ? undefined : Number(row.spendAmount),
        spellSlug: row.spellSlug ?? undefined,
      })),
      panelActions: (() => {
        const economyTextByKey = new Map<string, string>();
        for (const row of economyRows) {
          if (!row.classSlug || !row.tableAction) continue;
          const text = pickPlayableText(row.description, row.summary);
          if (!text) continue;
          economyTextByKey.set(`${row.classSlug}|${row.tableAction}`, text);
        }
        return panelRows.map((row) => ({
          panelKey: row.panelKey,
          classSlug: row.classSlug,
          subclassSlug: row.subclassSlug ?? undefined,
          slug: row.slug,
          name: row.name,
          title: row.title ?? undefined,
          description: pickPlayableText(
            economyTextByKey.get(`${row.classSlug}|${row.slug}`),
            row.title,
          ),
          minLevel: Number(row.unlockLevel),
          resourceSlug: row.resourceSlug ?? undefined,
          section: asPanelSection(row.section),
          spendsFocus: Boolean(row.spendsFocus),
          sortOrder: Number(row.sortOrder),
        }));
      })(),
    };
  }
}
