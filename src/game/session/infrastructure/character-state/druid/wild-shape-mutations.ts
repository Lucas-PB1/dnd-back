import { Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';

export async function applyWildShapeState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active: boolean;
  templateSlug?: string | null;
  actorId?: string | null;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;

  if (input.active) {
    state.wildShapeActive = true;
    state.wildShapeTemplateSlug = input.templateSlug ?? null;
    if (input.actorId !== undefined) {
      state.wildShapeActorId = input.actorId;
    }
  } else {
    state.wildShapeActive = false;
    state.wildShapeTemplateSlug = null;
    state.wildShapeActorId = null;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyWildShapeKnownFormsState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  knownSlugs: string[];
  formSwapAvailable?: boolean;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;
  state.wildShapeKnownSlugs = [...input.knownSlugs];
  if (input.formSwapAvailable !== undefined) {
    state.wildShapeFormSwapAvailable = input.formSwapAvailable;
  }
  await stateRepo.save(state);
  return buildResponse(character, state);
}
