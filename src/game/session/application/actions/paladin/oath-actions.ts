import { BadRequestException } from '@nestjs/common';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
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

const GLORIOUS_DEFENSE_RESOURCE = 'glorious-defense';

/** Defesa Gloriosa (Glória L15): reação — +CA (Carisma) e possível contra-ataque. */
export async function resolveGloriousDefense(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 15, 'Paladin', 'Defesa Gloriosa');
  if (character.subclassSlug !== 'glory') {
    throw new BadRequestException(
      'Defesa Gloriosa requires Oath of Glory',
    );
  }
  const chaBonus = Math.max(1, abilityModifier(character.abilityScores.carisma));
  const state = (
    await deps.state.useClassResource(character, GLORIOUS_DEFENSE_RESOURCE, 1)
  ).state;
  return {
    state,
    actionName: 'Defesa Gloriosa',
    resourceSpent: true,
    note:
      `Defesa Gloriosa (−1 uso): conceda +${chaBonus} CA ao alvo contra este ataque ` +
      `(mod. de Carisma, mín. +1). Se o ataque errar e o atacante estiver no alcance da sua arma, ` +
      'você pode atacar com uma arma como parte desta Reação (mesa).',
  };
}

const UNDYING_SENTINEL_RESOURCE = 'undying-sentinel';
const REVELER_RESOURCE = 'reveler';

/** Sentinela Imortal (Anciãos L15): a 0 PV → 1 PV + cura (3× nível). */
export async function resolveUndyingSentinel(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 15, 'Paladin', 'Sentinela Imortal');
  if (character.subclassSlug !== 'ancients') {
    throw new BadRequestException(
      'Sentinela Imortal requires Oath of the Ancients',
    );
  }
  const regained = 3 * character.level;
  const nextHp =
    character.hitPointsMax == null
      ? 1 + regained
      : Math.min(character.hitPointsMax, 1 + regained);
  await deps.state.useClassResource(character, UNDYING_SENTINEL_RESOURCE, 1);
  const state = await deps.state.patch(character, {
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
  });
  return {
    state,
    actionName: 'Sentinela Imortal',
    resourceSpent: true,
    total: nextHp,
    note:
      `Sentinela Imortal (−1 uso): defina seus PV atuais em ${nextHp} ` +
      `(1 + ${regained} recuperados = 3 × nível de Paladino, teto = PV máximos) ` +
      'e limpe salvaguardas contra morte. Ajuste o contador de PV na ficha.',
  };
}

/** Folião (Folia L15): reação — Vantagem em Teste d20. */
export async function resolveReveler(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 15, 'Paladin', 'Folião');
  if (character.subclassSlug !== 'oath-of-revelry') {
    throw new BadRequestException('Folião requires Oath of Revelry');
  }
  const state = (
    await deps.state.useClassResource(character, REVELER_RESOURCE, 1)
  ).state;
  return {
    state,
    actionName: 'Folião',
    resourceSpent: true,
    note:
      'Folião (−1 uso): conceda Vantagem a um Teste de D20 seu ou de um aliado a até 9 m. ' +
      'Se o teste ainda falhar, recupere este uso (mesa — use + no contador).',
  };
}
