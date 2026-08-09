import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import {
  CharacterStateResponseDto,
  UseClassResourceResponseDto,
} from '@game/session/dto/character-state.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';
import { resolveClassResources } from './class-resources';
import {
  applyRecoverClassResource,
  applyUseClassResource,
} from './resource-mutations';
import {
  consumeSpellSlot,
  loadMaxSlots,
  recoverSpellSlot,
} from './spell-slots';

export type ResourceSessionDeps = {
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  dataSource: DataSource;
  findOrCreate: (characterId: string, level: number) => Promise<PlayerCharacterState>;
  buildResponse: BuildResponse;
};

export async function useClassResourceOp(
  deps: ResourceSessionDeps,
  character: PlayerCharacter,
  resourceSlug: string,
  amount = 1,
): Promise<UseClassResourceResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyUseClassResource({
    character,
    state,
    resourceSlug,
    amount,
    stateRepo: deps.stateRepo,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function recoverClassResourceOp(
  deps: ResourceSessionDeps,
  character: PlayerCharacter,
  resourceSlug: string,
  amount = 1,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyRecoverClassResource({
    character,
    state,
    resourceSlug,
    amount,
    stateRepo: deps.stateRepo,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function spendClassResourceOp(
  deps: ResourceSessionDeps,
  character: PlayerCharacter,
  resourceSlug: string,
  amount = 1,
): Promise<void> {
  const state = await deps.findOrCreate(character.id, character.level);
  const resources = await resolveClassResources(deps.dataSource, character);
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
  await deps.stateRepo.save(state);
}

export async function consumeSpellSlotLevelOp(
  deps: ResourceSessionDeps,
  character: PlayerCharacter,
  slotLevel: number,
): Promise<void> {
  const state = await deps.findOrCreate(character.id, character.level);
  const maxSlots = await loadMaxSlots(
    deps.classSlots,
    deps.subclassSlots,
    character.classSlug,
    character.level,
    character.subclassSlug,
  );
  consumeSpellSlot(state, maxSlots, slotLevel, slotLevel);
  await deps.stateRepo.save(state);
}

export async function recoverSpellSlotLevelOp(
  deps: ResourceSessionDeps,
  character: PlayerCharacter,
  slotLevel: number,
): Promise<void> {
  const state = await deps.findOrCreate(character.id, character.level);
  recoverSpellSlot(state, slotLevel);
  await deps.stateRepo.save(state);
}
