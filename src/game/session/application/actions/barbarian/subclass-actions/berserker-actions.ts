import { rageDamageBonus } from '@game/combat/domain/barbarian';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import { rollDamageParts } from '@game/dice/domain/dice';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from '../barbarian-action-deps';
import {
  INTIMIDATING_PRESENCE,
} from '../barbarian-action-deps';
import { strengthSaveDc } from './strength-save-dc';

export async function resolveFrenzy(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Frenesi');
  const catalog = await deps.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const dice = rageDamageBonus(character.level, bands);
  const result = rollDamageParts(`${dice}d6`, 0);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Frenesi',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Frenesi: com Fúria + Imprudente, +${result.total} (${result.expression}) no 1º acerto FOR deste turno (mesmo tipo da arma).`,
  };
}

export async function resolveIntimidatingPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Presença Intimidante');
  const saveDc = await strengthSaveDc(deps, character);
  const state = (
    await deps.state.useClassResource(character, INTIMIDATING_PRESENCE, 1)
  ).state;
  return {
    state,
    actionName: 'Presença Intimidante',
    saveDc,
    resourceSpent: true,
    note: `Presença Intimidante: Ação Bônus — criaturas escolhidas em Emanação 9 m, CD ${saveDc} de SAB ou Amedrontadas 1 min. Restaure o uso gastando 1 Fúria (mesa: Usar Restaurar).`,
  };
}
