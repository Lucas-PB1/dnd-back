import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import type {
  ClericActionDeps,
  ClericTableActionResult,
  PlayerCharacter,
} from '../cleric-action-deps';
import {
  assertSubclassFeature,
  spendChannelDivinity,
  spellSaveDc,
} from '../cleric-action-deps';

export async function resolveRadianceOfDawn(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'light',
    'Domínio da Luz',
    'Brilho do Amanhecer',
  );
  const result = rollDamageParts('2d10', character.level);
  const state = await spendChannelDivinity(deps, character);
  const saveDc = await spellSaveDc(deps, character);
  return {
    state,
    actionName: 'Brilho do Amanhecer',
    expression: result.expression,
    total: result.total,
    saveDc,
    resourceSpent: true,
    note: `Brilho do Amanhecer: dissipa Escuridão mágica; CD ${saveDc} de CON, ${result.total} Radiante (${result.expression}) ou metade.`,
  };
}

export async function resolveWardingFlare(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'light',
    'Domínio da Luz',
    'Labareda Protetora',
  );
  const spent = await deps.state.useClassResource(
    character,
    'warding-flare',
    1,
  );

  if (character.level < 6) {
    return {
      state: spent.state,
      actionName: 'Labareda Protetora',
      resourceSpent: true,
      note: 'Labareda Protetora: Reação para impor Desvantagem ao ataque de uma criatura visível a até 9 m.',
    };
  }

  const result = rollDamageParts(
    '2d6',
    abilityModifier(character.abilityScores.sabedoria),
  );
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );
  return {
    state,
    actionName: 'Labareda Protetora Aprimorada',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Labareda Protetora: imponha Desvantagem e conceda ${result.total} PV temporários (${result.expression}) ao alvo do ataque. Aplicado na ficha — ajuste o contador se o alvo for um aliado.`,
  };
}

export async function resolveCrownOfLight(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'light',
    'Domínio da Luz',
    'Coroa de Luz',
    17,
  );
  const state = (
    await deps.state.useClassResource(character, 'corona-of-light', 1)
  ).state;
  return {
    state,
    actionName: 'Coroa de Luz',
    resourceSpent: true,
    note: 'Coroa de Luz: aura de luz solar por 1 minuto; inimigos na Luz Plena têm Desvantagem em salvaguardas contra seu dano Ígneo ou Radiante.',
  };
}
