import { martialArtsDie, martialArtsDieFaces } from '@game/combat/domain/monk';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyHealHitPoints } from '@game/session/application/core/apply-heal-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  MonkActionDeps,
  MonkTableActionResult,
  PlayerCharacter,
} from '../monk-action-deps';
import { focusDc, spendFocus, spendResource } from '../monk-action-deps';

const WHOLENESS_SLUG = 'wholeness-of-body';

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
    note: `Técnica da Mão Espalmada: ao acertar com a Torrente de Golpes, cada ataque pode impor Caído (Destreza CD ${saveDc}), empurrar 4,5 m (Força CD ${saveDc}) ou impedir Reações até o início do próximo turno do alvo.`,
  };
}

export async function resolveWholenessOfBody(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'open-hand', 'Mão Espalmada');
  assertCharacterLevel(character, 6, 'Monk', 'Integridade Corporal');
  const wisdom = Math.max(
    1,
    abilityModifier(character.abilityScores.sabedoria),
  );
  const heal = rollDamageParts(martialArtsDie(character.level), wisdom);
  await spendResource(deps, character, WHOLENESS_SLUG, 1);
  const { state, healed } = await applyHealHitPoints(
    deps.state,
    character,
    heal.total,
  );
  return {
    state,
    actionName: 'Integridade Corporal',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Integridade Corporal: Ação Bônus — recupere ${heal.total} PV (${heal.expression}; +${healed} na ficha). Usos = mod. de Sabedoria (mín. 1)/DL.`,
  };
}

export async function resolveVibratingPalm(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'open-hand', 'Mão Espalmada');
  assertCharacterLevel(character, 17, 'Monk', 'Palma Vibrante');
  const saveDc = await focusDc(deps, character);
  const state = await spendFocus(deps, character, 4);
  return {
    state,
    actionName: 'Palma Vibrante',
    saveDc,
    resourceSpent: true,
    note: `Palma Vibrante: no acerto desarmado, gaste 4 Foco para iniciar vibrações (duração = nível de Monge em dias; 1 alvo). Para encerrar (ação ou abrindo mão de um ataque na ação Atacar, mesmo plano): salvaguarda de Constituição CD ${saveDc} → 10d12 Energético (metade no sucesso). Pode encerrar inofensivamente sem ação.`,
  };
}

export async function resolveElementalAttunement(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'elements', 'Combatente dos Elementos');
  assertCharacterLevel(character, 3, 'Monk', 'Sintonia Elemental');
  const saveDc = await focusDc(deps, character);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Sintonia Elemental',
    saveDc,
    resourceSpent: true,
    note: `Sintonia Elemental: no início do turno, gaste 1 Foco (10 min ou até Incapacitado). Ataques Desarmados: dano Ácido/Elétrico/Gélido/Ígneo/Trovejante à escolha; alcance +3 m; no acerto com esses tipos, Força CD ${saveDc} ou mover o alvo 3 m.`,
  };
}

export async function resolveElementalBlast(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'elements', 'Combatente dos Elementos');
  assertCharacterLevel(character, 6, 'Monk', 'Explosão Elemental');
  const saveDc = await focusDc(deps, character);
  const faces = martialArtsDieFaces(character.level);
  const damage = rollDamageParts(`3d${faces}`, 0);
  const state = await spendFocus(deps, character, 2);
  return {
    state,
    actionName: 'Explosão Elemental',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    saveDc,
    resourceSpent: true,
    note: `Explosão Elemental: Usar Magia, gaste 2 Foco. Esfera 6 m de raio centrada a até 36 m. Tipo (Ácido/Elétrico/Gélido/Ígneo/Trovejante). Cada criatura: Destreza CD ${saveDc} → ${damage.total} (${damage.expression}) ou metade no sucesso.`,
  };
}

export async function resolveShadowArts(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'shadow', 'Combatente das Sombras');
  assertCharacterLevel(character, 3, 'Monk', 'Artes das Sombras');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Artes das Sombras — Escuridão',
    resourceSpent: true,
    note: 'Artes das Sombras: gaste 1 Foco para conjurar Escuridão sem componentes. Você vê na área; no início de cada turno pode mover a área até 18 m. (Visão no Escuro 18 m / +18 m e Ilusão Menor = permanentes.)',
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
    note: 'Passo da Sombra: em Meia-luz ou Escuridão, Ação Bônus — teleporte até 18 m para espaço desocupado sob Meia-luz/Escuridão à vista. Vantagem no próximo ataque corpo a corpo neste turno.',
  };
}

export async function resolveImprovedShadowStep(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'shadow', 'Combatente das Sombras');
  assertCharacterLevel(character, 11, 'Monk', 'Passo da Sombra Aprimorado');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Passo da Sombra Aprimorado',
    resourceSpent: true,
    note: 'Passo da Sombra Aprimorado: ao usar Passo da Sombra, gaste 1 Foco para ignorar o requisito de Meia-luz/Escuridão no início/fim e faça 1 Ataque Desarmado imediatamente após o teleporte.',
  };
}

export async function resolveCloakOfShadows(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'shadow', 'Combatente das Sombras');
  assertCharacterLevel(character, 17, 'Monk', 'Manto da Sombra');
  const state = await spendFocus(deps, character, 3);
  return {
    state,
    actionName: 'Manto da Sombra',
    resourceSpent: true,
    note: 'Manto da Sombra: em Meia-luz/Escuridão, Usar Magia, gaste 3 Foco (1 min ou até Incapacitado / terminar turno em Luz Plena). Invisível; atravessa espaços ocupados como terreno difícil; Torrente sem gastar Foco.',
  };
}
