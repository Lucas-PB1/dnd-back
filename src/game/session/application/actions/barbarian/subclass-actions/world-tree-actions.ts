import { rageDamageBonus } from '@game/combat/domain/barbarian';
import { rollDamageParts } from '@game/dice/domain/dice';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from '../barbarian-action-deps';
import { strengthSaveDc } from './strength-save-dc';

export async function resolveRevitalizingStrength(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'world-tree', 'Árvore do Mundo');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Força Revigorante');
  const dice = rageDamageBonus(character.level);
  const result = rollDamageParts(`${dice}d6`, 0);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );
  return {
    state,
    actionName: 'Força Revigorante',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Força Revigorante: no início do turno (Fúria ativa), conceda ${result.total} PV temp. (${result.expression}) a outro a 3 m. Total aplicado na ficha — ajuste se for aliado.`,
  };
}

export async function resolveBranchesOfTheTree(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'world-tree', 'Árvore do Mundo');
  assertCharacterLevel(character, 6, 'Bárbaro', 'Ramos da Árvore');
  const saveDc = await strengthSaveDc(deps, character);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Ramos da Árvore',
    saveDc,
    resourceSpent: false,
    note: `Ramos da Árvore: Reação (Fúria) — criatura a 9 m, CD ${saveDc} de FOR ou teleporta a 1,5 m de você; Deslocamento 0 até o fim do turno dela.`,
  };
}

export async function resolveTraverseTheTree(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'world-tree', 'Árvore do Mundo');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Percorrer a Árvore');
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Percorrer a Árvore',
    resourceSpent: false,
    note: 'Percorrer a Árvore: teleporte até 18 m (ao entrar em Fúria ou AB enquanto ativa). 1×/Fúria: até 45 m e leve até 6 aliados a 3 m.',
  };
}
