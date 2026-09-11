import { rageDamageBonus } from '@game/combat/domain/barbarian';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
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
  const catalog = await deps.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const dice = rageDamageBonus(character.level, bands);
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
