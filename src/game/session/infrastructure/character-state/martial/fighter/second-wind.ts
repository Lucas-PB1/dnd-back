import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import {
  hasTacticalShift,
  isFighterClass,
  secondWindHealDice,
} from '../../../../../combat/domain/fighter-features';
import { rollExpression } from '../../../../../dice/domain/dice';
import { PlayerCharacter } from '../../../../../shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '../../../../domain/class-resources';
import { SecondWindResponseDto } from '../../../../dto/character-state.dto';
import { PlayerCharacterState } from '../../../player-character-state.entity';
import { resolveClassResources } from '../../resources/class-resources';
import type { BuildResponse } from '../../core/mutation-types';

export async function applySecondWind(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  characters: { save: (row: PlayerCharacter) => Promise<unknown> };
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<SecondWindResponseDto> {
  const { character, state, stateRepo, characters, dataSource, buildResponse } =
    input;
  if (!isFighterClass(character.classSlug)) {
    throw new BadRequestException('Second Wind requires the Fighter class');
  }
  if (
    character.hitPointsMax == null ||
    character.hitPointsCurrent == null
  ) {
    throw new BadRequestException('Character hit points are not set');
  }

  const resources = await resolveClassResources(dataSource, character);
  const secondWind = resources.find((item) => item.slug === 'secondWind');
  if (!secondWind) {
    throw new BadRequestException('Second Wind is not available');
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      'secondWind',
      secondWind.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Second Wind',
    );
  }

  const expression = secondWindHealDice(character.level);
  const healRoll = rollExpression(expression);
  const before = character.hitPointsCurrent;
  const after = Math.min(character.hitPointsMax, before + healRoll.total);
  const healAmount = after - before;
  character.hitPointsCurrent = after;

  await stateRepo.save(state);
  await characters.save(character);

  const notes: string[] = [];
  if (hasTacticalShift(character.level)) {
    notes.push(
      'Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO',
    );
  }

  return {
    state: await buildResponse(character, state),
    expression: healRoll.expression,
    healAmount,
    hitPointsCurrent: after,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
