import type { LoadCombatMechanicalCatalog } from '../../../../combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UseRangerTableActionDto,
} from '../../../dto/character-state.dto';
import { CharacterStateRepository } from '../../../infrastructure/character-state.repository';

export const FAVORED_ENEMY_SLUG = 'favoredEnemy';
export const TIRELESS_SLUG = 'tireless';
export const NATURES_VEIL_SLUG = 'naturesVeil';
export const FEY_REINFORCEMENTS_SLUG = 'fey-reinforcements';
export const MISTY_WANDERER_SLUG = 'misty-wanderer';

export type RangerActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type RangerTableActionResult = FighterTableActionResponseDto;
export type { PlayerCharacter, UseRangerTableActionDto };
