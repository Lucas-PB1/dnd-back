import { BadRequestException } from '@nestjs/common';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type { PaladinTableActionResult } from '../paladin-action-deps';
import type { PaladinActionDeps, PlayerCharacter } from '../paladin-action-deps';

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
