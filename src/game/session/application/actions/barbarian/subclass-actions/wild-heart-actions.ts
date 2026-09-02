import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import { BadRequestException } from '@nestjs/common';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from '../barbarian-action-deps';

export async function resolveWildHeartEagle(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'wild-heart', 'Coração Selvagem');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Águia');
  const state = await deps.state.buildResponse(character);
  if (!state.rageActive) {
    throw new BadRequestException('Águia requer Fúria ativa');
  }
  return {
    state,
    actionName: 'Fúria dos Selvagens — Águia',
    resourceSpent: false,
    note: 'Águia: Ação Bônus — Correr e Desengajar (também ao ativar a Fúria como parte dessa AB).',
  };
}
