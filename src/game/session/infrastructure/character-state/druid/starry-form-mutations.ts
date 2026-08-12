import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import type { StellarConstellation } from '@game/combat/domain/druid/starry-form-state';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterStateResponseDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';

export async function applyStarryFormState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active: boolean;
  constellation?: StellarConstellation | null;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;

  if (character.subclassSlug !== 'stars') {
    throw new BadRequestException(
      'Starry Form requires the Circle of Stars subclass',
    );
  }

  if (input.active) {
    if (!input.constellation) {
      throw new BadRequestException(
        'Stellar constellation is required while Starry Form is active',
      );
    }
    state.starryFormActive = true;
    state.stellarConstellation = input.constellation;
  } else {
    state.starryFormActive = false;
    state.stellarConstellation = null;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}
