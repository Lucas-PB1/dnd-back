import { martialArtsDie } from '../../../../combat/domain/monk-features';
import { rollDamageParts } from '../../../../dice/domain/dice';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../core/table-action-guards';
import type {
  MonkActionDeps,
  MonkTableActionResult,
  PlayerCharacter,
} from './monk-action-deps';
import { focusDc, spendFocus } from './monk-action-deps';

export async function resolveOpenHandTechnique(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'open-hand', 'Mão Espalmada');
  assertCharacterLevel(character, 3, 'Monk', 'Técnica da Mão Espalmada');
  const saveDc = await focusDc(deps, character);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Técnica da Mão Espalmada',
    saveDc,
    resourceSpent: false,
    note: `Técnica da Mão Espalmada: ao acertar com a Torrente de Golpes, cada ataque pode impor Caído (salvaguarda de Destreza CD ${saveDc}), empurrar 4,5 m (salvaguarda de Força CD ${saveDc}) ou impedir Reações até seu próximo turno.`,
  };
}

export async function resolveElementalBlast(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'elements', 'Combatente dos Elementos');
  assertCharacterLevel(character, 3, 'Monk', 'Explosão Elemental');
  const dexterity = abilityModifier(character.abilityScores.destreza);
  const damage = rollDamageParts(martialArtsDie(character.level), dexterity);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Explosão Elemental',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    resourceSpent: true,
    note: `Explosão Elemental: gaste 1 Foco para atacar à distância (18 m) com alcance elemental; dano ${damage.total} do tipo elemental escolhido (${damage.expression}).`,
  };
}

export async function resolveHandOfHealing(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 3, 'Monk', 'Mão de Cura');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const heal = rollDamageParts(martialArtsDie(character.level), wisdom);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Mão de Cura',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Mão de Cura: gaste 1 Foco para curar ${heal.total} PV (${heal.expression}) em uma criatura ao alcance.`,
  };
}

export async function resolveHandOfHarm(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 3, 'Monk', 'Mão de Dolo');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const damage = rollDamageParts(martialArtsDie(character.level), wisdom);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Mão de Dolo',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    resourceSpent: true,
    note: `Mão de Dolo: ao acertar um Ataque Desarmado, gaste 1 Foco (1×/turno) para +${damage.total} de dano Necrótico (${damage.expression}).`,
  };
}

export async function resolveShadowStep(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'shadow', 'Combatente das Sombras');
  assertCharacterLevel(character, 6, 'Monk', 'Passo da Sombra');
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Passo da Sombra',
    resourceSpent: false,
    note: 'Passo da Sombra: na penumbra ou escuridão, teleporte-se até 9 m para outra área de penumbra/escuridão; seu próximo ataque corpo a corpo neste turno tem Vantagem.',
  };
}
