import { BadRequestException } from '@nestjs/common';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  COLD_PLUNGE_COLD_ACTION,
  COLD_PLUNGE_WATER_ACTION,
  type MesaCircumstanceTag,
  SNOWRUNNER_TOGGLE_ACTION,
  toggleMesaCircumstance,
} from '@game/session/domain/mesa-circumstances';

const ACTION_TO_TAG: Readonly<Record<string, MesaCircumstanceTag>> = {
  [SNOWRUNNER_TOGGLE_ACTION]: 'snow_ice',
  [COLD_PLUNGE_WATER_ACTION]: 'in_water',
  [COLD_PLUNGE_COLD_ACTION]: 'extreme_cold',
};

const FEAT_FOR_ACTION: Readonly<Record<string, string>> = {
  [SNOWRUNNER_TOGGLE_ACTION]: 'snowrunner',
  [COLD_PLUNGE_WATER_ACTION]: 'cold-plunge-training',
  [COLD_PLUNGE_COLD_ACTION]: 'cold-plunge-training',
};

export function isMesaCircumstanceToggleAction(
  featSlug: string,
  actionSlug: string,
): boolean {
  return FEAT_FOR_ACTION[actionSlug] === featSlug;
}

export async function applyMesaCircumstanceToggle(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  actionSlug: string;
  actionName: string;
  enabled?: boolean;
}): Promise<TableActionResponseDto> {
  const tag = ACTION_TO_TAG[input.actionSlug];
  if (!tag) {
    throw new BadRequestException(
      `Toggle de circunstância desconhecido: ${input.actionSlug}`,
    );
  }
  const current = await input.state.buildResponse(input.character);
  const next = toggleMesaCircumstance(
    current.mesaCircumstances,
    tag,
    input.enabled,
  );
  const state = await input.state.patch(input.character, {
    mesaCircumstances: next,
  });
  const on = next.includes(tag);
  return {
    state,
    actionName: input.actionName,
    resourceSpent: false,
    note: on
      ? `${input.actionName}: circunstância '${tag}' ativa na ficha.`
      : `${input.actionName}: circunstância '${tag}' desligada.`,
  };
}
