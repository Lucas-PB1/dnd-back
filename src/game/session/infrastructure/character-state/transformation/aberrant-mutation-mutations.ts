import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';
import type { AberrantMutationSlug } from '@game/session/domain/transformation/aberrant-mutation';

export async function applyAberrantMutationState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  mutationSlug: AberrantMutationSlug | null;
  stateRepo: { save: (row: PlayerCharacterState) => Promise<PlayerCharacterState> };
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  input.state.aberrantMutationActive = input.mutationSlug;
  await input.stateRepo.save(input.state);
  return input.buildResponse(input.character);
}
