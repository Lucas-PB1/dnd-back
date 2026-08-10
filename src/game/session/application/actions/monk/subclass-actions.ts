import { martialArtsDie, martialArtsDieFaces } from '@game/combat/domain/monk';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  MonkActionDeps,
  MonkTableActionResult,
  PlayerCharacter,
} from './monk-action-deps';
import { focusDc, spendFocus, spendResource } from './monk-action-deps';

const WHOLENESS_SLUG = 'wholeness-of-body';
const FLURRY_HEAL_HARM_SLUG = 'hand-of-harm-flurry';
const ULTIMATE_MERCY_SLUG = 'hand-of-ultimate-mercy';
const STREET_KNOCKOUT_SLUG = 'street-knockout';

// —— Open Hand ——

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
  const spent = await spendResource(deps, character, WHOLENESS_SLUG, 1);
  return {
    state: spent,
    actionName: 'Integridade Corporal',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Integridade Corporal: Ação Bônus — recupere ${heal.total} PV (${heal.expression}). Usos = mod. de Sabedoria (mín. 1)/DL.`,
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

// —— Elements ——

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

// —— Mercy ——

export async function resolveHandOfHealing(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 3, 'Monk', 'Mão de Cura');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const heal = rollDamageParts(martialArtsDie(character.level), wisdom);
  const state = await spendFocus(deps, character, 1);
  const touch =
    character.level >= 6
      ? ' Também pode encerrar Atordoado, Cego, Envenenado, Paralisado ou Surdo no alvo (Toque de Médico).'
      : '';
  return {
    state,
    actionName: 'Mão de Cura',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Mão de Cura: Usar Magia, gaste 1 Foco — cure ${heal.total} PV (${heal.expression}). Na Torrente, pode substituir 1 ataque desarmado por esta cura sem gastar Foco da cura.${touch}`,
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
  const poison =
    character.level >= 6
      ? ' Também pode impor Envenenado até o fim do seu próximo turno (Toque de Médico).'
      : '';
  return {
    state,
    actionName: 'Mão de Dolo',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    resourceSpent: true,
    note: `Mão de Dolo: 1×/turno no acerto desarmado, gaste 1 Foco para +${damage.total} Necrótico (${damage.expression}).${poison}`,
  };
}

export async function resolveFlurryOfHealingAndHarm(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 11, 'Monk', 'Torrente de Cura e Dolo');
  const state = await spendResource(
    deps,
    character,
    FLURRY_HEAL_HARM_SLUG,
    1,
  );
  return {
    state,
    actionName: 'Torrente de Cura e Dolo',
    resourceSpent: true,
    note: 'Torrente de Cura e Dolo: nesta Torrente, cada ataque desarmado pode ser substituído por Mão de Cura sem gastar Foco da cura; e 1×/turno Mão de Dolo sem gastar Foco do dolo. Usos = mod. de Sabedoria (mín. 1)/DL.',
  };
}

export async function resolveHandOfUltimateMercy(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 17, 'Monk', 'Mão da Misericórdia Final');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const heal = rollDamageParts('4d10', wisdom);
  await spendFocus(deps, character, 5);
  const state = await spendResource(
    deps,
    character,
    ULTIMATE_MERCY_SLUG,
    1,
  );
  return {
    state,
    actionName: 'Mão da Misericórdia Final',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Mão da Misericórdia Final: Usar Magia, toque cadáver (≤24 h), gaste 5 Foco + 1 uso. Revive com ${heal.total} PV (${heal.expression}); remove Atordoado/Cego/Envenenado/Paralisado/Surdo. 1×/DL.`,
  };
}

// —— Shadow ——

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

// —— Warrior of the Street ——

export async function resolveStreetCombo(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 3, 'Monk', 'Combinação');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Combinação',
    resourceSpent: true,
    note: 'Combinação: no acerto desarmado com dano, gaste 1 Foco. Até o fim do turno: +2 nas jogadas de ataque desarmado; +2 por acerto sucessivo (máx. +6). Reseta para +2 se sofrer dano ou errar um ataque.',
  };
}

export async function resolveEnergyBurst(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 6, 'Monk', 'Explosão de Energia');
  const saveDc = await focusDc(deps, character);
  const faces = martialArtsDieFaces(character.level);
  const damage = rollDamageParts(`2d${faces}`, 0);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Explosão de Energia',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    saveDc,
    resourceSpent: true,
    note: `Explosão de Energia: na ação Atacar, gaste 1 Foco para substituir 1 ataque. Alvo a até 18 m: Destreza CD ${saveDc} → ${damage.total} Energético (${damage.expression}) ou metade no sucesso.`,
  };
}

export async function resolveGuardBreaker(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 6, 'Monk', 'Quebrador de Guarda');
  const dex = abilityModifier(character.abilityScores.destreza);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Quebrador de Guarda',
    total: dex,
    resourceSpent: true,
    note: `Quebrador de Guarda: ao errar Ataque Desarmado, gaste 1 Foco — o alvo ainda sofre ${dex} de dano (mod. de Destreza). Este erro não reseta o bônus de Combinação.`,
  };
}

export async function resolveUppercut(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 6, 'Monk', 'Corte Superior');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Corte Superior',
    resourceSpent: true,
    note: 'Corte Superior: no acerto desarmado com dano, gaste 1 Foco — empurre o alvo até 1,5 m e imponha Caído se for Grande ou menor.',
  };
}

export async function resolveAirDash(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 11, 'Monk', 'Traço Aéreo');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Traço Aéreo',
    resourceSpent: true,
    note: 'Traço Aéreo: no seu turno (sem ação), gaste 1 Foco — Deslocamento de Voo igual ao seu Deslocamento até o fim do próximo turno; Vantagem no próximo ataque corpo a corpo neste turno.',
  };
}

export async function resolveKnockout(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 17, 'Monk', 'K.O.');
  const faces = martialArtsDieFaces(character.level);
  const damage = rollDamageParts(`3d${faces}`, 0);
  const state = await spendResource(
    deps,
    character,
    STREET_KNOCKOUT_SLUG,
    1,
  );
  return {
    state,
    actionName: 'K.O.',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    resourceSpent: true,
    note: `K.O.: 1×/turno no acerto desarmado — +${damage.total} Energético (${damage.expression}). Se o alvo ficar com ≤100 PV após o ataque, Inconsciente 10 min. 1×/Descanso Curto ou Longo (ou recupere com Gambito: 5 Foco).`,
  };
}

export async function resolveRecoverKnockout(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, 17, 'Monk', 'K.O.');
  await spendFocus(deps, character, 5);
  const state = await deps.state.recoverClassResource(
    character,
    STREET_KNOCKOUT_SLUG,
    1,
  );
  return {
    state,
    actionName: 'Recuperar K.O.',
    resourceSpent: true,
    note: 'Recuperar K.O.: gaste 5 Foco para recuperar 1 uso de K.O. (sem ação).',
  };
}
