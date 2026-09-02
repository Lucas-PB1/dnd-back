import { rageDamageBonus } from '@game/combat/domain/barbarian';
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
  RAGE_RESOURCE,
} from '../barbarian-action-deps';
import { strengthSaveDc } from './strength-save-dc';

export async function resolveFrenzy(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Frenesi');
  const dice = rageDamageBonus(character.level);
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

export async function resolveRetaliation(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 10, 'Bárbaro', 'Retaliação');
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Retaliação',
    resourceSpent: false,
    note: 'Retaliação: Reação ao sofrer dano de criatura a 1,5 m — faça um ataque corpo a corpo (arma ou Desarmado).',
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

export async function resolveRestoreIntimidatingPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Presença Intimidante');
  await deps.state.useClassResource(character, RAGE_RESOURCE, 1);
  const state = await deps.state.recoverClassResource(
    character,
    INTIMIDATING_PRESENCE,
    1,
  );
  return {
    state,
    actionName: 'Restaurar Presença Intimidante',
    resourceSpent: true,
    note: 'Restaurou Presença Intimidante gastando 1 uso de Fúria.',
  };
}
