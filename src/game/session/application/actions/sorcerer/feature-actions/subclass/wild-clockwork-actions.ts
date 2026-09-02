import { BadRequestException } from '@nestjs/common';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  SorcererActionDeps,
  SorcererTableActionResult,
} from '../../sorcerer-action-deps';
import { spendPoints } from '../../sorcerer-action-deps';

export const TIDES_OF_CHAOS_RESOURCE = 'tides-of-chaos';
export const RESTORE_BALANCE_RESOURCE = 'restore-balance';

export async function resolveTidesOfChaos(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'wild-magic', 'Feitiçaria Selvagem');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Marés do Caos');
  await deps.state.useClassResource(character, TIDES_OF_CHAOS_RESOURCE, 1);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Marés do Caos',
    resourceSpent: true,
    note: 'Marés do Caos: ganhe Vantagem em um Teste de D20 à sua escolha. Recarrega ao conjurar magia de Feiticeiro com espaço (Surto) ou no Descanso Longo.',
  };
}

export async function resolveBendLuck(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'wild-magic', 'Feitiçaria Selvagem');
  assertCharacterLevel(character, 6, 'Feiticeiro', 'Distorcer a Sorte');
  const state = await spendPoints(deps, character, 1);

  return {
    state,
    actionName: 'Distorcer a Sorte',
    resourceSpent: true,
    total: 1,
    note: 'Distorcer a Sorte: Reação — gaste 1 Ponto de Feitiçaria e aplique +1d4 ou −1d4 ao Teste de D20 de outra criatura à sua vista.',
  };
}

export async function resolveBastionOfLaw(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  pointsSpent?: number,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'clockwork', 'Feitiçaria Mecânica');
  assertCharacterLevel(character, 6, 'Feiticeiro', 'Bastião da Lei');
  const cost = pointsSpent ?? 1;
  if (!Number.isInteger(cost) || cost < 1 || cost > 5) {
    throw new BadRequestException(
      'Bastião da Lei: gaste de 1 a 5 Pontos de Feitiçaria',
    );
  }
  const state = await spendPoints(deps, character, cost);

  return {
    state,
    actionName: 'Bastião da Lei',
    resourceSpent: true,
    total: cost,
    note: `Bastião da Lei: gastou ${cost} Pontos de Feitiçaria → ${cost}d8 de proteção a uma criatura a até 9 m (reduz dano até Descanso Longo ou novo uso).`,
  };
}

export async function resolveRestoreBalance(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'clockwork', 'Feitiçaria Mecânica');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Restaurar Equilíbrio');
  await deps.state.useClassResource(character, RESTORE_BALANCE_RESOURCE, 1);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Restaurar Equilíbrio',
    resourceSpent: true,
    note: 'Restaurar Equilíbrio: Reação — o Teste de D20 escolhido não é afetado por Vantagem nem Desvantagem.',
  };
}
