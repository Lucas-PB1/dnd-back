import {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import type { MartialSessionDeps, PlayerCharacter } from './martial-deps';
import { applyToggleSacredWeapon } from './paladin-mutations';

export async function toggleSacredWeaponOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  active?: boolean,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyToggleSacredWeapon({
    character,
    state,
    active,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}
