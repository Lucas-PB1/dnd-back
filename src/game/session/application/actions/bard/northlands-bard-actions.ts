import { bardicInspirationDie } from '@game/combat/domain/bard';
import { rollDamageParts } from '@game/dice/domain/dice';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BardActionDeps,
  BardTableActionResult,
  PlayerCharacter,
} from './bard-action-deps';
import { spendInspiration } from './bard-action-deps';

/**
 * Runa da Fala de Bragi — Vitalidade (PV temp. = dado de Inspiração).
 * Escárnio / Eloquência: declare na mesa; se Usar for Vitalidade, PV já aplicados.
 */
export async function resolveBragiRune(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'skald', 'Skald');
  assertCharacterLevel(character, 6, 'Bardo', 'Runa da Fala de Bragi');

  const die = bardicInspirationDie(character.level);
  const result = rollDamageParts(`1${die}`, 0);
  await spendInspiration(deps, character);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );

  return {
    state,
    actionName: 'Runa da Fala de Bragi',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Vitalidade: ${result.total} PV temp. (${result.expression}) em você e até 3 aliados a 9 m — total aplicado na ficha (ajuste se distribuir). Escárnio/Eloquência: declare na mesa e ignore estes PV temp. se não for Vitalidade.`,
  };
}
