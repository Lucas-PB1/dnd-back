import { BadRequestException } from '@nestjs/common';
import { rollDamageParts } from '@game/dice/domain/dice';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type { PaladinTableActionResult } from './paladin-action-deps';
import {
  CHANNEL_DIVINITY_SLUG,
  paladinSaveDc,
  type PaladinActionDeps,
  type PlayerCharacter,
} from './paladin-action-deps';

function oathChannelName(subclassSlug: string | null): string {
  switch (subclassSlug) {
    case 'devotion':
      return 'Arma Sagrada';
    case 'glory':
      return 'Destruição Inspiradora';
    case 'ancients':
      return 'A Ira da Natureza';
    case 'vengeance':
      return 'Voto de Inimizade';
    case 'oath-of-revelry':
      return 'Conjurar Bebida';
    default:
      return 'Canalizar Divindade do Juramento';
  }
}

function oathChannelNote(subclassSlug: string | null): string {
  switch (subclassSlug) {
    case 'devotion':
      return 'Arma Sagrada: ao Atacar, imbuir arma corpo a corpo por 10 min — +mod. de Carisma (mín. +1) no ataque, dano pode ser Radiante, Luz Plena 6 m / Fraca +6 m';
    case 'glory':
      return 'Destruição Inspiradora: após Destruição Divina, distribua PV temp. (2d8 + nível de Paladino) a criaturas a até 9 m';
    case 'ancients':
      return 'A Ira da Natureza: ação Usar Magia — criaturas a até 4,5 m salvaguarda de Força ou Contidas por 1 min';
    case 'vengeance':
      return 'Voto de Inimizade: ao Atacar, escolha um alvo a até 9 m — Vantagem nos ataques contra ele por 1 min';
    case 'oath-of-revelry':
      return 'Conjurar Bebida: canecas (até mod. de Carisma) — beber concede PV temp. e Vantagem em salvaguardas por 1 min';
    default:
      return 'Use uma opção de Canalizar Divindade do seu juramento';
  }
}

export async function resolveOathChannel(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  if (character.subclassSlug === 'glory') {
    return resolveInspiringSmite(deps, character);
  }
  assertCharacterLevel(
    character,
    3,
    'Paladin',
    'Canalizar Divindade do Juramento',
  );
  const saveDc = await paladinSaveDc(deps, character);
  const state = (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
  return {
    state,
    actionName: oathChannelName(character.subclassSlug),
    saveDc,
    resourceSpent: true,
    note: `${oathChannelNote(character.subclassSlug)} (1 uso de Canalizar Divindade; CD ${saveDc} quando houver salvaguarda).`,
  };
}

/** Destruição Inspiradora (Glória L3): após Destruição Divina — 2d8 + nível em PV temp. */
export async function resolveInspiringSmite(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 3, 'Paladin', 'Destruição Inspiradora');
  if (character.subclassSlug !== 'glory') {
    throw new BadRequestException(
      'Destruição Inspiradora requires Oath of Glory',
    );
  }
  await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1);
  const pool = rollDamageParts('2d8', character.level);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    pool.total,
  );
  return {
    state,
    actionName: 'Destruição Inspiradora',
    expression: pool.expression,
    total: pool.total,
    resourceSpent: true,
    note: `Destruição Inspiradora: ${pool.total} PV temporários (${pool.expression}) para distribuir entre você e criaturas a até 9 m. Total aplicado na ficha como PV temp. seus — ajuste o contador se dividir na mesa. (1 uso de Canalizar Divindade).`,
  };
}

/** Atleta Inigualável (Glória L3): 2º canal — Vantagem em Atletismo/Acrobacia. */
export async function resolvePeerlessAthlete(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 3, 'Paladin', 'Atleta Inigualável');
  if (character.subclassSlug !== 'glory') {
    throw new BadRequestException(
      'Atleta Inigualável requires Oath of Glory',
    );
  }
  const state = (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Atleta Inigualável',
    resourceSpent: true,
    note: 'Atleta Inigualável: por 1 h, Vantagem em Força (Atletismo) e Destreza (Acrobacia); Saltos Longos e em Altura +3 m (custa movimento). (1 uso de Canalizar Divindade).',
  };
}
