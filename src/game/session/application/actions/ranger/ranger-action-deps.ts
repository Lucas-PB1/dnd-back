import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseRangerTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const FAVORED_ENEMY_SLUG = 'favoredEnemy';
export const TIRELESS_SLUG = 'tireless';
export const NATURES_VEIL_SLUG = 'naturesVeil';
export const FEY_REINFORCEMENTS_SLUG = 'fey-reinforcements';
export const MISTY_WANDERER_SLUG = 'misty-wanderer';

export type RangerActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type RangerTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseRangerTableActionDto };
