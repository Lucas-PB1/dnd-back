import type { CombatMechanicalCatalogResponseDto } from '../dto/combat-mechanical-catalog-response.dto';

export type CombatMechanicalCatalogFilters = {
  classSlug?: string;
  subclassSlug?: string;
  featSlug?: string;
  itemSlug?: string;
  speciesSlug?: string;
  threadSlug?: string;
  heritageTraitSlug?: string;
};

const BATTLE_MASTER_SUBCLASS = 'battle-master';
const GUNSLINGER_CLASS = 'gunslinger';
const BARD_CLASS = 'bard';
const ROGUE_CLASS = 'rogue';
const FIGHTER_CLASS = 'fighter';
const DUNGEONEER_SUBCLASS = 'dungeoneer';
const BEASTBORNE_SUBCLASS = 'beastborne';

function gunslingerManeuversForFilters(
  catalog: CombatMechanicalCatalogResponseDto,
  classSlug: string | undefined,
  subclassSlug: string | undefined,
): CombatMechanicalCatalogResponseDto['gunslingerManeuvers'] {
  const subclassInCatalog =
    subclassSlug != null &&
    catalog.gunslingerManeuvers.some(
      (maneuver) => maneuver.subclassSlug === subclassSlug,
    );
  const include =
    (!subclassSlug && (!classSlug || classSlug === GUNSLINGER_CLASS)) ||
    subclassInCatalog;
  if (!include) return [];

  if (!subclassSlug) return catalog.gunslingerManeuvers;
  return catalog.gunslingerManeuvers.filter(
    (maneuver) =>
      !maneuver.subclassSlug || maneuver.subclassSlug === subclassSlug,
  );
}


function catalogForOwnerEconomy(
  catalog: CombatMechanicalCatalogResponseDto,
  economyActions: CombatMechanicalCatalogResponseDto['economyActions'],
): CombatMechanicalCatalogResponseDto {
  return {
    ...catalog,
    economyActions,
    panelActions: [],
    gunslingerManeuvers: [],
    battleMasterManeuvers: [],
    cunningStrikeEffects: [],
    strikeOptions: [],
    tableActions: [],
    personaMasks: [],
    beastborneAspectBenefits: [],
    dungeoneerSlayerLabels: [],
    precautionSpells: [],
  };
}

export function filterCombatMechanicalCatalog(
  catalog: CombatMechanicalCatalogResponseDto,
  filters: CombatMechanicalCatalogFilters,
): CombatMechanicalCatalogResponseDto {
  const classSlug = filters.classSlug?.trim() || undefined;
  const subclassSlug = filters.subclassSlug?.trim() || undefined;
  const featSlug = filters.featSlug?.trim() || undefined;
  const itemSlug = filters.itemSlug?.trim() || undefined;
  const speciesSlug = filters.speciesSlug?.trim() || undefined;
  const threadSlug = filters.threadSlug?.trim() || undefined;
  const heritageTraitSlug = filters.heritageTraitSlug?.trim() || undefined;
  if (
    !classSlug &&
    !subclassSlug &&
    !featSlug &&
    !itemSlug &&
    !speciesSlug &&
    !threadSlug &&
    !heritageTraitSlug
  ) {
    return catalog;
  }

  if (featSlug || itemSlug || speciesSlug || threadSlug || heritageTraitSlug) {
    let economyActions = catalog.economyActions;
    if (featSlug) {
      economyActions = economyActions.filter(
        (action) => action.featSlug === featSlug,
      );
    }
    if (itemSlug) {
      economyActions = economyActions.filter(
        (action) => action.itemSlug === itemSlug,
      );
    }
    if (speciesSlug) {
      economyActions = economyActions.filter(
        (action) => action.speciesSlug === speciesSlug,
      );
    }
    if (threadSlug) {
      economyActions = economyActions.filter(
        (action) => action.threadSlug === threadSlug,
      );
    }
    if (heritageTraitSlug) {
      economyActions = economyActions.filter(
        (action) => action.heritageTraitSlug === heritageTraitSlug,
      );
    }
    return catalogForOwnerEconomy(catalog, economyActions);
  }

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

  const strikeOptions = catalog.strikeOptions.filter((option) => {
    if (subclassSlug) {
      return !option.subclassSlug || option.subclassSlug === subclassSlug;
    }
    if (classSlug && classSlug !== FIGHTER_CLASS) {
      return false;
    }
    return true;
  });

  const tableActions = subclassSlug
    ? catalog.tableActions.filter(
        (action) => action.subclassSlug === subclassSlug,
      )
    : catalog.tableActions;

  return {
    ...catalog,
    economyActions,
    panelActions,
    gunslingerManeuvers: gunslingerManeuversForFilters(
      catalog,
      classSlug,
      subclassSlug,
    ),
    battleMasterManeuvers: includeBattleMaster
      ? catalog.battleMasterManeuvers
      : [],
    cunningStrikeEffects,
    strikeOptions,
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
