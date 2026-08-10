import type { CombatMechanicalCatalogResponseDto } from '../dto/combat-mechanical-catalog-response.dto';

export type CombatMechanicalCatalogFilters = {
  classSlug?: string;
  subclassSlug?: string;
};

const BATTLE_MASTER_SUBCLASS = 'battle-master';
const GUNSLINGER_CLASS = 'gunslinger';
const GUNSLINGER_SUBCLASS = 'pistolero';
const BARD_CLASS = 'bard';
const ROGUE_CLASS = 'rogue';
const FIGHTER_CLASS = 'fighter';
const DUNGEONEER_SUBCLASS = 'dungeoneer';
const BEASTBORNE_SUBCLASS = 'beastborne';

/** Aplica filtros opcionais sem alterar o catálogo completo quando omitidos. */
export function filterCombatMechanicalCatalog(
  catalog: CombatMechanicalCatalogResponseDto,
  filters: CombatMechanicalCatalogFilters,
): CombatMechanicalCatalogResponseDto {
  const classSlug = filters.classSlug?.trim() || undefined;
  const subclassSlug = filters.subclassSlug?.trim() || undefined;
  if (!classSlug && !subclassSlug) return catalog;

  let economyActions = catalog.economyActions;
  let panelActions = catalog.panelActions;

  if (classSlug) {
    economyActions = economyActions.filter(
      (action) => !action.classSlug || action.classSlug === classSlug,
    );
    panelActions = panelActions.filter(
      (action) => action.classSlug === classSlug,
    );
  }

  if (subclassSlug) {
    economyActions = economyActions.filter(
      (action) => !action.subclassSlug || action.subclassSlug === subclassSlug,
    );
    panelActions = panelActions.filter(
      (action) => !action.subclassSlug || action.subclassSlug === subclassSlug,
    );
  }

  const includeBattleMaster =
    (!subclassSlug && (!classSlug || classSlug === FIGHTER_CLASS)) ||
    subclassSlug === BATTLE_MASTER_SUBCLASS;
  const includeGunslinger =
    (!subclassSlug && (!classSlug || classSlug === GUNSLINGER_CLASS)) ||
    subclassSlug === GUNSLINGER_SUBCLASS;
  const includePersonaMasks = !classSlug || classSlug === BARD_CLASS;
  const includeCunning = !classSlug || classSlug === ROGUE_CLASS;
  const includeDungeoneer =
    !subclassSlug || subclassSlug === DUNGEONEER_SUBCLASS;
  const includeBeastborne =
    !subclassSlug || subclassSlug === BEASTBORNE_SUBCLASS;

  const cunningStrikeEffects = includeCunning
    ? catalog.cunningStrikeEffects.filter(
        (effect) =>
          !subclassSlug ||
          !effect.subclassSlug ||
          effect.subclassSlug === subclassSlug,
      )
    : [];

  const tableActions = subclassSlug
    ? catalog.tableActions.filter(
        (action) => action.subclassSlug === subclassSlug,
      )
    : catalog.tableActions;

  return {
    ...catalog,
    economyActions,
    panelActions,
    gunslingerManeuvers: includeGunslinger ? catalog.gunslingerManeuvers : [],
    battleMasterManeuvers: includeBattleMaster
      ? catalog.battleMasterManeuvers
      : [],
    cunningStrikeEffects,
    tableActions,
    personaMasks: includePersonaMasks ? catalog.personaMasks : [],
    beastborneAspectBenefits: includeBeastborne
      ? catalog.beastborneAspectBenefits
      : [],
    dungeoneerSlayerLabels: includeDungeoneer
      ? catalog.dungeoneerSlayerLabels
      : [],
    precautionSpells: includeDungeoneer ? catalog.precautionSpells : [],
  };
}
