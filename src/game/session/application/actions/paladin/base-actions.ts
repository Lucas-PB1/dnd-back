import { BadRequestException } from '@nestjs/common';
import { assertCharacterLevel } from '../../core/table-action-guards';
import type { PaladinTableActionResult } from './paladin-action-deps';
import {
  CHANNEL_DIVINITY_SLUG,
  CURE_POISON_COST,
  LAY_ON_HANDS_SLUG,
  paladinSaveDc,
  type PaladinActionDeps,
  type PlayerCharacter,
} from './paladin-action-deps';

export async function resolveLayOnHands(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
  amount: number | undefined,
): Promise<PaladinTableActionResult> {
  const points = amount ?? 1;
  if (points < 1) {
    throw new BadRequestException('Lay on Hands requires at least 1 point');
  }
  const state = (
    await deps.state.useClassResource(character, LAY_ON_HANDS_SLUG, points)
  ).state;
  return {
    state,
    actionName: 'Mãos Consagradas',
    total: points,
    resourceSpent: true,
    note: `Mãos Consagradas: cure ${points} PV (reserva de 5 × nível).`,
  };
}

export async function resolveCurePoison(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  const state = (
    await deps.state.useClassResource(
      character,
      LAY_ON_HANDS_SLUG,
      CURE_POISON_COST,
    )
  ).state;
  return {
    state,
    actionName: 'Mãos Consagradas — Curar Veneno',
    total: CURE_POISON_COST,
    resourceSpent: true,
    note: 'Mãos Consagradas: gaste 5 PV da reserva para remover a condição Envenenado.',
  };
}

export async function resolveDivineSense(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 3, 'Paladin', 'Sentido Divino');
  const state = (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Sentido Divino',
    resourceSpent: true,
    note: 'Sentido Divino: até o fim do próximo turno, saiba a posição de Celestiais, Corruptores e Mortos-vivos em 18 m (1 uso de Canalizar Divindade).',
  };
}

export async function resolveAbjureEnemies(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 9, 'Paladin', 'Repudiar Inimigos');
  const saveDc = await paladinSaveDc(deps, character);
  const state = (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Repudiar Inimigos',
    saveDc,
    resourceSpent: true,
    note: `Repudiar Inimigos: criaturas escolhidas fazem salvaguarda de Sabedoria CD ${saveDc}; na falha ficam Amedrontadas e com Deslocamento 0.`,
  };
}
