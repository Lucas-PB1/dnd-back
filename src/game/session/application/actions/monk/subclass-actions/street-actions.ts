import { martialArtsDieFaces } from '@game/combat/domain/monk';
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
} from '../monk-action-deps';
import { focusDc, spendFocus, spendResource } from '../monk-action-deps';

const STREET_KNOCKOUT_SLUG = 'street-knockout';

function assertStreet(character: PlayerCharacter, feature: string, level: number) {
  assertCharacterSubclass(
    character,
    'warrior-of-the-street',
    'Guerreiro das Ruas',
  );
  assertCharacterLevel(character, level, 'Monk', feature);
}

export async function resolveStreetCombo(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertStreet(character, 'Combinação', 3);
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
  assertStreet(character, 'Explosão de Energia', 6);
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
  assertStreet(character, 'Quebrador de Guarda', 6);
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
  assertStreet(character, 'Corte Superior', 6);
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
  assertStreet(character, 'Traço Aéreo', 11);
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
  assertStreet(character, 'K.O.', 17);
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
  assertStreet(character, 'K.O.', 17);
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
