import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  applyResourceRecover,
  applyResourceSpend,
} from '@game/session/domain/class-resources';
import { rollRiskDie } from '@game/session/domain/maneuver-resolve';
import {
  CharacterStateResponseDto,
  UseClassResourceResponseDto,
} from '@game/session/dto/character-state.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { resolveClassResources } from './class-resources';
import type { BuildResponse } from '../core/mutation-types';

export async function applyUseClassResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  resourceSlug: string;
  amount: number;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<UseClassResourceResponseDto> {
  const {
    character,
    state,
    resourceSlug,
    amount,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `Resource '${resourceSlug}' is not available for this character`,
    );
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      resourceSlug,
      resource.max,
      amount,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend resource',
    );
  }

  const roll = resourceSlug === 'risk' ? rollRiskDie(character.level) : null;

  await stateRepo.save(state);
  return {
    state: await buildResponse(character, state),
    roll,
  };
}

export async function applyRecoverClassResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  resourceSlug: string;
  amount: number;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    resourceSlug,
    amount,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `Resource '${resourceSlug}' is not available for this character`,
    );
  }

  state.resourcesUsed = applyResourceRecover(
    state.resourcesUsed ?? {},
    resourceSlug,
    amount,
  );
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applySetPersonaMasks(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  masks: string[];
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, masks, stateRepo, buildResponse } = input;
  state.personaMasks = masks;
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applySetBestialAspectLevel(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  level: number;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, level, stateRepo, buildResponse } = input;
  state.bestialAspectLevel = level;
  await stateRepo.save(state);
  return buildResponse(character, state);
}
