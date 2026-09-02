import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from '../barbarian-action-deps';

const MUSCLE_WIZARD_SLUG = 'path-of-the-muscle-wizard' as const;
const MUSCLE_WIZARD_LABEL = 'Mago Musculoso' as const;

export async function resolveCantripMageHand(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 3, 'Bárbaro', 'Mãos Mágicas');
  const state = await deps.state.buildResponse(character);
  const meters = state.rageActive ? 3 : 1.5;
  return {
    state,
    actionName: '“Truque” — Mãos Mágicas',
    resourceSpent: false,
    note: `Mãos Mágicas: no acerto FOR, empurre o alvo (Grande ou menor) ${meters} m${state.rageActive ? ' (Fúria)' : ''}.`,
  };
}

export async function resolveCantripShockingGrasp(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 3, 'Bárbaro', 'Toque Chocante');
  const state = await deps.state.buildResponse(character);
  return {
    state,
    actionName: '“Truque” — Toque Chocante',
    resourceSpent: false,
    note: state.rageActive
      ? 'Toque Chocante (Fúria): o alvo não pode fazer OA até o início do seu próximo turno.'
      : 'Toque Chocante: o alvo não pode fazer OA até o fim do turno atual.',
  };
}

export async function resolveUndeniableMagicRage(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 3, 'Bárbaro', 'Magia indiscutível');
  const state = await deps.state.martial.toggleRage(character, true, false);
  return {
    state,
    actionName: 'Magia indiscutível (Fúria)',
    resourceSpent: false,
    note: 'Magia indiscutível: Reação — entre em Fúria até o fim do seu próximo turno sem gastar uso (não estende).',
  };
}

export async function resolveCantripSureStrike(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 3, 'Bárbaro', 'Ataque Certeiro');
  const before = await deps.state.buildResponse(character);
  const halfLevel = Math.floor(character.level / 2);
  const bonus = before.rageActive ? halfLevel : 0;
  const result = rollDamageParts('1d6', bonus);
  return {
    state: before,
    actionName: '“Truque” — Ataque Certeiro',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Ataque Certeiro: +${result.total} (${result.expression}) no acerto FOR${before.rageActive ? ' (Fúria: +metade do nível)' : ''}.`,
  };
}

export async function resolveBurningHandsSlap(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 6, 'Bárbaro', 'Mãos Flamejantes');
  const str = abilityModifier(character.abilityScores.forca);
  const result = rollDamageParts('1d8', str);
  return {
    state: await deps.state.buildResponse(character),
    actionName: '“Magia” — Mãos Flamejantes',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Mãos Flamejantes (1×/DL enquanto Fúria): ação — Ataque Desarmado em cada criatura no alcance; no acerto ${result.total} Contundente (${result.expression}) e Desvantagem no próximo ataque dela. Marque o uso na mesa.`,
  };
}

export async function resolveMagicMissileThrows(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 6, 'Bárbaro', 'Mísseis Mágicos');
  return {
    state: await deps.state.buildResponse(character),
    actionName: '“Magia” — Mísseis Mágicos',
    resourceSpent: false,
    note: 'Mísseis Mágicos (1×/DL enquanto Fúria): ação — 3 ataques à distância com arma de arremesso FOR; Vantagem (nunca erra). Marque o uso.',
  };
}

export async function resolveShieldBlock(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 6, 'Bárbaro', 'Escudo');
  return {
    state: await deps.state.buildResponse(character),
    actionName: '“Magia” — Escudo',
    resourceSpent: false,
    note: `Escudo (1×/DL enquanto Fúria): Reação ao ser atingido — +CA do Escudo; se ainda acertar, reduza o dano em ${character.level}. Marque o uso.`,
  };
}

export async function resolveICastFist(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, MUSCLE_WIZARD_SLUG, MUSCLE_WIZARD_LABEL);
  assertCharacterLevel(character, 14, 'Bárbaro', 'Eu lancei o punho');
  const str = abilityModifier(character.abilityScores.forca);
  const result = rollDamageParts('6d6', str);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Eu lancei o punho',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Eu lancei o punho (1×/Fúria): substitua um ataque — Desarmado com Vantagem; no acerto ${result.total} Contundente (${result.expression}) e Caído (Enorme ou menor).`,
  };
}
