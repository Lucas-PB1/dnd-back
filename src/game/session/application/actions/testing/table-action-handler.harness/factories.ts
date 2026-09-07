import type { CombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionTestCharacter } from './types';

const DEFAULT_SCORES: AbilityScores = {
  forca: 10,
  destreza: 14,
  constituicao: 12,
  inteligencia: 10,
  sabedoria: 12,
  carisma: 10,
};

export function createTestAbilityScores(
  overrides: Partial<AbilityScores> = {},
): AbilityScores {
  return { ...DEFAULT_SCORES, ...overrides };
}

export function createTestCharacter(
  overrides: Partial<TableActionTestCharacter> &
    Pick<TableActionTestCharacter, 'classSlug'>,
): TableActionTestCharacter {
  return {
    id: 'char-1',
    userId: 'user-1',
    subclassSlug: null,
    level: 5,
    hitPointsCurrent: 20,
    hitPointsMax: 40,
    abilityScores: createTestAbilityScores(),
    ...overrides,
  };
}

export function createEmptyMechanicalCatalogLoad(
  overrides: Partial<CombatMechanicalCatalog> = {},
): CombatMechanicalCatalog {
  return {
    gunslingerManeuvers: [],
    battleMasterManeuvers: [],
    cunningStrikeEffects: [],
    tableActions: [],
    personaMasks: [],
    personaMaskSlugs: [],
    beastborneAspectBenefits: [],
    dungeoneerSlayerLabels: [],
    precautionSpells: [],
    economyActions: [],
    panelActions: [],
    ...overrides,
  };
}
