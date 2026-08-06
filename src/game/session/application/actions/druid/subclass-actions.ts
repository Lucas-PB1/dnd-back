import { moonWildShapeTempHp } from '../../../../combat/domain/druid-features';
import { rollDamageParts } from '../../../../dice/domain/dice';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from './druid-action-deps';
import { spendWildShape } from './druid-action-deps';

export async function resolveStarryFormArcher(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  assertCharacterLevel(character, 3, 'Druida', 'Forma Estelar (Arquiro)');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const result = rollDamageParts('1d8', wisdom);
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Forma Estelar: Arquiro',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Forma Estelar (Arquiro): Ação Bônus desfere um ataque à distância radiante causando ${result.total} de dano radiante (${result.expression}).`,
  };
}

export async function resolveStarryFormChalice(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  assertCharacterLevel(character, 3, 'Druida', 'Forma Estelar (Cálice)');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const result = rollDamageParts('1d8', wisdom);
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Forma Estelar: Cálice',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Forma Estelar (Cálice): ao conjurar uma magia de cura, você ou uma criatura a até 9 m recupera ${result.total} PV adicionais (${result.expression}).`,
  };
}

export async function resolveStarryFormDragon(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  assertCharacterLevel(character, 3, 'Druida', 'Forma Estelar (Dragão)');
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Forma Estelar: Dragão',
    resourceSpent: true,
    note: 'Forma Estelar (Dragão): em testes de Inteligência, Sabedoria ou salvaguardas de Concentração, qualquer resultado menor que 10 no d20 torna-se 10.',
  };
}

export async function resolveWrathOfTheSea(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'sea', 'Círculo do Mar');
  assertCharacterLevel(character, 3, 'Druida', 'Ira do Mar');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const diceCount = Math.max(1, wisdom);
  const result = rollDamageParts(`${diceCount}d6`, 0);
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Ira do Mar',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Ira do Mar: Ação Bônus emana aura de tempestade a 3 m. Causa ${result.total} de dano elétrico/concussão (${result.expression}) e empurra a criatura atingida em 4,5 m.`,
  };
}

export async function resolveMoonCombatWildShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'moon', 'Círculo da Lua');
  assertCharacterLevel(character, 3, 'Druida', 'Forma Selvagem de Combate');
  const tempHp = moonWildShapeTempHp(character.level);
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Forma Selvagem de Combate',
    resourceSpent: true,
    total: tempHp,
    note: `Forma Selvagem de Combate: ganha ${tempHp} PV temporários, CA = 13 + Mod. Sabedoria e pode gastar slots de magia para se curar com Ação Bônus.`,
  };
}
