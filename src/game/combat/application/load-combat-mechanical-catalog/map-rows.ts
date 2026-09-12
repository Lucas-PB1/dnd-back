import type { PhbBattleMasterManeuver } from '@entities/subclass-feature/phb-battle-master-maneuver.entity';
import type { PhbBeastborneAspectBenefit } from '@entities/subclass-feature/phb-beastborne-aspect-benefit.entity';
import type { PhbClassPanelAction } from '@entities/class/phb-class-panel-action.entity';
import type { PhbCunningStrikeEffect } from '@entities/subclass-feature/phb-cunning-strike-effect.entity';
import type { PhbDungeoneerSlayerType } from '@entities/subclass-feature/phb-dungeoneer-slayer-type.entity';
import type { PhbGunslingerManeuver } from '@entities/subclass-feature/phb-gunslinger-maneuver.entity';
import type { PhbPersonaMask } from '@entities/subclass-feature/phb-persona-mask.entity';
import type { PhbSubclassPrecautionSpell } from '@entities/subclass-feature/phb-subclass-precaution-spell.entity';
import type { PhbSubclassTableAction } from '@entities/subclass-feature/phb-subclass-table-action.entity';
import type { VPhbClassEconomyAction } from '@entities/views/v-phb-class-economy-action.entity';
import type { BattleMasterManeuver } from '../../domain/fighter';
import type { ManeuverEffectKind } from '../../domain/gunslinger';
import type { CunningStrikeEffect } from '../../domain/rogue/types';
import type { StrikeOption } from '../../domain/strike-option';
import { mapEconomyActions, mapPanelActions } from './map-ui-actions';
import type { CombatMechanicalCatalog } from './types';

export type CombatMechanicalCatalogRows = {
  gunslingerRows: PhbGunslingerManeuver[];
  battleMasterRows: PhbBattleMasterManeuver[];
  cunningRows: PhbCunningStrikeEffect[];
  strikeOptions: StrikeOption[];
  tableActionRows: PhbSubclassTableAction[];
  personaRows: PhbPersonaMask[];
  beastborneRows: PhbBeastborneAspectBenefit[];
  slayerRows: PhbDungeoneerSlayerType[];
  precautionRows: PhbSubclassPrecautionSpell[];
  economyRows: VPhbClassEconomyAction[];
  panelRows: PhbClassPanelAction[];
  featureGatesBySubclassSlug: ReadonlyMap<
    string,
    ReadonlyMap<string, number>
  >;
  featureGatesByClassSlug: ReadonlyMap<string, ReadonlyMap<string, number>>;
  featureSchedulesByClassSlug: ReadonlyMap<
    string,
    readonly import('../../domain/feature-schedule').FeatureScheduleBand[]
  >;
  featureSchedulesBySubclassSlug: ReadonlyMap<
    string,
    readonly import('../../domain/feature-schedule').FeatureScheduleBand[]
  >;
};

export function mapCombatMechanicalCatalog(
  rows: CombatMechanicalCatalogRows,
): CombatMechanicalCatalog {
  const {
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
    featureGatesByClassSlug,
    featureSchedulesByClassSlug,
    featureSchedulesBySubclassSlug,
  } = rows;

  return {
    gunslingerManeuvers: gunslingerRows.map((row) => ({
      slug: row.slug,
      name: row.name,
      description: row.description,
      effectKind: row.effectKind as ManeuverEffectKind,
      riskCost: Number(row.riskCost),
      fromLevel: Number(row.fromLevel),
      subclassSlug: row.subclass?.slug ?? undefined,
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
        row.subclass?.slug === 'thief' ||
        row.subclass?.slug === 'arachnoid-stalker'
          ? row.subclass.slug
          : undefined,
      note: row.note,
    })),
    strikeOptions,
    tableActions: tableActionRows.map((row) => ({
      subclassSlug: row.subclass.slug,
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
      slug: row.spell.slug,
      name: row.spell.name,
    })),
    economyActions: mapEconomyActions(economyRows),
    panelActions: mapPanelActions(economyRows, panelRows),
    featureGatesBySubclassSlug,
    featureGatesByClassSlug,
    featureSchedulesByClassSlug,
    featureSchedulesBySubclassSlug,
  };
}
