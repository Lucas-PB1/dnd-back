import { HUNTERS_MARK_SPELL_SLUG } from '@game/combat/domain/ranger';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  RangerActionDeps,
  RangerTableActionResult,
} from './ranger-action-deps';
import {
  FAVORED_ENEMY_SLUG,
  NATURES_VEIL_SLUG,
  TIRELESS_SLUG,
} from './ranger-action-deps';

export async function resolveHuntersMarkFree(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  await deps.state.useClassResource(character, FAVORED_ENEMY_SLUG, 1);
  const state = await deps.state.patch(character, {
    concentratingOn: HUNTERS_MARK_SPELL_SLUG,
  });
  return {
    state,
    actionName: 'Marca do Predador (gratuita)',
    resourceSpent: true,
    note: 'Inimigo Favorito: Marca do Predador conjurada sem espaço; concentração iniciada. Cause o dado extra no acerto pela ficha.',
  };
}

export async function resolveTireless(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  assertCharacterLevel(character, 10, 'Patrulheiro', 'Incansável');
  const wisdom = Math.max(1, abilityModifier(character.abilityScores.sabedoria));
  const heal = rollDamageParts('1d8', wisdom);
  await deps.state.useClassResource(character, TIRELESS_SLUG, 1);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    heal.total,
  );
  return {
    state,
    actionName: 'Incansável',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Incansável: você ganha ${heal.total} PV temporários (${heal.expression}) — aplicados na ficha. Descanso Curto reduz Exaustão em 1.`,
  };
}

export async function resolveNaturesVeil(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  assertCharacterLevel(character, 14, 'Patrulheiro', 'Véu da Natureza');
  const state = (
    await deps.state.useClassResource(character, NATURES_VEIL_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Véu da Natureza',
    resourceSpent: true,
    note: 'Véu da Natureza: Ação Bônus — você fica Invisível até o fim do seu próximo turno.',
  };
}
