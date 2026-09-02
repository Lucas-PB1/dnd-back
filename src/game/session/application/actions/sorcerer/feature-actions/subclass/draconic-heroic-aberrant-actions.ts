import { rollDamageParts } from '@game/dice/domain/dice';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  SorcererActionDeps,
  SorcererTableActionResult,
} from '../../sorcerer-action-deps';
import { spendPoints } from '../../sorcerer-action-deps';
import { remainingResource } from '../class-features';

export const DRAGON_WINGS_RESOURCE = 'dragon-wings';
export const WARP_IMPLOSION_RESOURCE = 'warp-implosion';

export async function resolveDragonWings(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'draconic', 'Linhagem Dracônica');
  assertCharacterLevel(character, 14, 'Feiticeiro', 'Asas de Dragão');

  const wingsLeft = await remainingResource(
    deps,
    character,
    DRAGON_WINGS_RESOURCE,
  );

  let spentNote: string;
  if (wingsLeft > 0) {
    await deps.state.useClassResource(character, DRAGON_WINGS_RESOURCE, 1);
    spentNote = '1 uso';
  } else {
    await spendPoints(deps, character, 3);
    spentNote = '3 Pontos de Feitiçaria (restaurou o uso)';
  }

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Asas de Dragão',
    resourceSpent: true,
    note: `Asas de Dragão (${spentNote}): Ação Bônus — asas por 1 hora; Deslocamento de Voo 18 m.`,
  };
}

export async function resolveHeroicSoul(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'heroic-sorcery', 'Feitiçaria Heróica');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Alma Heróica');
  await spendPoints(deps, character, 1);
  const roll = rollDamageParts('1d6', character.level);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    roll.total,
  );

  return {
    state,
    actionName: 'Alma Heróica',
    expression: roll.expression,
    total: roll.total,
    resourceSpent: true,
    note: `Alma Heróica: gastou 1 Ponto de Feitiçaria → ${roll.total} PV temporários (${roll.expression}) aplicados na ficha.`,
  };
}

export async function resolveMysticalManeuver(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'heroic-sorcery', 'Feitiçaria Heróica');
  assertCharacterLevel(character, 14, 'Feiticeiro', 'Manobra Mística');
  const state = await spendPoints(deps, character, 2);

  return {
    state,
    actionName: 'Manobra Mística',
    resourceSpent: true,
    total: 2,
    note: 'Manobra Mística: gastou 2 Pontos de Feitiçaria (Ação Bônus após acertar) → +2d8 no dano e escolha Cegar, Ruinoso (−3 CA) ou Ferimento (sangramento).',
  };
}

export async function resolveWarpImplosion(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'aberrant', 'Feitiçaria Aberrante');
  assertCharacterLevel(character, 18, 'Feiticeiro', 'Implosão de Distorção');
  await deps.state.useClassResource(character, WARP_IMPLOSION_RESOURCE, 1);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Implosão de Distorção',
    resourceSpent: true,
    note: 'Implosão de Distorção: ação Usar Magia — teleporte e dano espacial conforme a ficha (1×/Descanso Longo).',
  };
}
