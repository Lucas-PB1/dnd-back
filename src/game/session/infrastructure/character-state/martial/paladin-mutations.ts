import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { isPaladinClass } from '@game/combat/domain/paladin';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';

export async function applyToggleSacredWeapon(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active?: boolean;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;
  if (!isPaladinClass(character.classSlug)) {
    throw new BadRequestException('Sacred Weapon requires the Paladin class');
  }
  if (character.subclassSlug !== 'devotion') {
    throw new BadRequestException(
      'Sacred Weapon requires the Oath of Devotion',
    );
  }
  state.sacredWeaponActive = input.active ?? !state.sacredWeaponActive;
  await stateRepo.save(state);
  return buildResponse(character, state);
}
