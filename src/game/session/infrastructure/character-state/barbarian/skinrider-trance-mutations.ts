import { Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';

export async function applySkinriderTranceState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active: boolean;
  actorId?: string | null;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;

  if (input.active) {
    state.skinriderTranceActive = true;
    if (input.actorId !== undefined) {
      state.skinriderActorId = input.actorId;
    }
  } else {
    state.skinriderTranceActive = false;
    state.skinriderActorId = null;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}
