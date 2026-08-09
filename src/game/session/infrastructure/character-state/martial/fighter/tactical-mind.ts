import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import {
  hasTacticalMind,
  isFighterClass,
} from '@game/combat/domain/fighter';
import { rollDie } from '@game/dice/domain/dice';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { TacticalMindResponseDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { resolveClassResources } from '@game/session/infrastructure/character-state/resources/class-resources';
import type { BuildResponse } from '@game/session/infrastructure/character-state/core/mutation-types';

export async function applyTacticalMind(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  checkTotal?: number;
  dc?: number;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<TacticalMindResponseDto> {
  const {
    character,
    state,
    checkTotal,
    dc,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  if (!isFighterClass(character.classSlug) || !hasTacticalMind(character.level)) {
    throw new BadRequestException(
      'Tactical Mind requires Fighter level 2+',
    );
  }

  const resources = await resolveClassResources(dataSource, character);
  const secondWind = resources.find((item) => item.slug === 'secondWind');
  if (!secondWind) {
    throw new BadRequestException('Second Wind is not available');
  }

  const remaining =
    secondWind.max - (state.resourcesUsed?.secondWind ?? 0);
  if (remaining <= 0) {
    throw new BadRequestException('No remaining uses of Second Wind');
  }

  const roll = rollDie(10);
  const hasCheckContext =
    typeof checkTotal === 'number' && typeof dc === 'number';

  if (hasCheckContext) {
    const newTotal = checkTotal + roll;
    const success = newTotal >= dc;

    if (success) {
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
      await stateRepo.save(state);
    }

    return {
      state: await buildResponse(character, state),
      expression: '1d10',
      roll,
      newTotal,
      success,
      resourceSpent: success,
      note: success
        ? 'Mente Tática: sucesso; uso de Recuperar Fôlego gasto'
        : 'Mente Tática: ainda falhou; uso de Recuperar Fôlego devolvido',
    };
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
  await stateRepo.save(state);

  return {
    state: await buildResponse(character, state),
    expression: '1d10',
    roll,
    resourceSpent: true,
    note: `Mente Tática: +${roll} (1d10). Some ao teste; se ainda falhar, devolva o uso de Recuperar Fôlego.`,
  };
}
