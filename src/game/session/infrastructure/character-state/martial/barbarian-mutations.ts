import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { CharacterStateResponseDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { resolveClassResources } from '../resources/class-resources';
import type { BuildResponse } from '../core/mutation-types';

export async function applyToggleRage(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active?: boolean;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, dataSource, buildResponse } = input;
  if (character.classSlug !== 'barbarian') {
    throw new BadRequestException('Rage requires the Barbarian class');
  }

  const nextActive = input.active ?? !state.rageActive;
  if (nextActive && !state.rageActive) {
    const resources = await resolveClassResources(dataSource, character);
    const rage = resources.find((item) => item.slug === 'rage');
    if (!rage) {
      throw new BadRequestException('Rage is not available yet');
    }
    try {
      state.resourcesUsed = applyResourceSpend(
        state.resourcesUsed ?? {},
        'rage',
        rage.max,
        1,
      );
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot spend Rage',
      );
    }
    state.rageActive = true;
  } else if (!nextActive) {
    state.rageActive = false;
    state.recklessActive = false;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyToggleReckless(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active?: boolean;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;
  if (character.classSlug !== 'barbarian') {
    throw new BadRequestException('Reckless Attack requires the Barbarian class');
  }
  if (character.level < 2) {
    throw new BadRequestException('Reckless Attack unlocks at level 2');
  }
  state.recklessActive = input.active ?? !state.recklessActive;
  await stateRepo.save(state);
  return buildResponse(character, state);
}

/** Fúria Persistente (nv.15): recupera todos os usos de Fúria na iniciativa. */
export async function applyRecoverAllRage(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;
  if (character.classSlug !== 'barbarian' || character.level < 15) {
    throw new BadRequestException(
      'Persistent Rage recovery requires Barbarian level 15+',
    );
  }
  const used = { ...(state.resourcesUsed ?? {}) };
  delete used.rage;
  state.resourcesUsed = used;
  await stateRepo.save(state);
  return buildResponse(character, state);
}
