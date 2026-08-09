import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { isFighterClass } from '@game/combat/domain/fighter-features';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { ActionSurgeResponseDto } from '@game/session/dto/character-state.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { resolveClassResources } from '@game/session/infrastructure/character-state/resources/class-resources';
import type { BuildResponse } from '@game/session/infrastructure/character-state/core/mutation-types';

export async function applyActionSurge(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<ActionSurgeResponseDto> {
  const { character, state, stateRepo, dataSource, buildResponse } = input;
  if (!isFighterClass(character.classSlug) || character.level < 2) {
    throw new BadRequestException('Action Surge requires Fighter level 2+');
  }

  const resources = await resolveClassResources(dataSource, character);
  const surge = resources.find((item) => item.slug === 'actionSurge');
  if (!surge) {
    throw new BadRequestException('Action Surge is not available');
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      'actionSurge',
      surge.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Action Surge',
    );
  }

  await stateRepo.save(state);

  const notes = [
    'Surto de Ação: execute uma ação adicional (exceto Usar Magia)',
  ];
  if (
    character.subclassSlug === 'eldritch-knight' &&
    character.level >= 15
  ) {
    notes.push(
      'Investida Mística: teleporte até 9 m antes ou depois da ação adicional',
    );
  }

  return {
    state: await buildResponse(character, state),
    note: notes.join(' · '),
  };
}
