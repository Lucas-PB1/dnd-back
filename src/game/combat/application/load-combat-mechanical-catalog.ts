import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBattleMasterManeuver } from '../../../entities/views/v-phb-battle-master-maneuver.entity';
import { VPhbBeastborneAspectBenefit } from '../../../entities/views/v-phb-beastborne-aspect-benefit.entity';
import { VPhbClassEconomyAction } from '../../../entities/views/v-phb-class-economy-action.entity';
import { VPhbClassPanelAction } from '../../../entities/views/v-phb-class-panel-action.entity';
import { VPhbCunningStrikeEffect } from '../../../entities/views/v-phb-cunning-strike-effect.entity';
import { VPhbDungeoneerSlayerType } from '../../../entities/views/v-phb-dungeoneer-slayer-type.entity';
import { VPhbGunslingerManeuver } from '../../../entities/views/v-phb-gunslinger-maneuver.entity';
import { VPhbPersonaMask } from '../../../entities/views/v-phb-persona-mask.entity';
import { VPhbSubclassPrecautionSpell } from '../../../entities/views/v-phb-subclass-precaution-spell.entity';
import { VPhbSubclassTableAction } from '../../../entities/views/v-phb-subclass-table-action.entity';
import type { BattleMasterManeuver } from '../domain/battle-master-maneuvers';
import type {
  ActionEconomyBucket,
  ClassEconomyActionRecord,
  ClassPanelActionRecord,
  PanelActionSection,
} from '../domain/class-action-ui-catalog';
import type { PrecautionSpell } from '../domain/dungeoneer-catalog';
import type { GunslingerManeuver, ManeuverEffectKind } from '../domain/gunslinger-maneuvers';
import type { CunningStrikeEffect } from '../domain/rogue/types';
import type { SubclassTableAction } from '../domain/subclass-table-action';

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

@Injectable()
export class LoadCombatMechanicalCatalog {
  private cache: CombatMechanicalCatalog | null = null;

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
    if (this.cache) return this.cache;

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

    this.cache = {
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
      })),
      panelActions: panelRows.map((row) => ({
        panelKey: row.panelKey,
        classSlug: row.classSlug,
        subclassSlug: row.subclassSlug ?? undefined,
        slug: row.slug,
        name: row.name,
        title: row.title ?? undefined,
        minLevel: Number(row.unlockLevel),
        resourceSlug: row.resourceSlug ?? undefined,
        section: asPanelSection(row.section),
        spendsFocus: Boolean(row.spendsFocus),
        sortOrder: Number(row.sortOrder),
      })),
    };

    return this.cache;
  }

  clearCache(): void {
    this.cache = null;
  }
}
