import { bardicInspirationDie } from '@game/combat/domain/bard';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BardActionDeps,
  BardTableActionResult,
  PlayerCharacter,
} from '../bard-action-deps';
import { spendInspiration } from '../bard-action-deps';

async function bardBands(deps: BardActionDeps, character: PlayerCharacter) {
  const catalog = await deps.mechanicalCatalog.load();
  return featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
}

export async function resolveAgileResponse(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 6, 'Bardo', 'Movimento Inspirador');
  const state = await spendInspiration(deps, character);

  return {
    state,
    actionName: 'Movimento Inspirador',
    resourceSpent: true,
    note: 'Movimento Inspirador: Reação quando um inimigo à sua vista encerra o turno a até 1,5 m. Gaste 1 Inspiração de Bardo para se mover até metade do Deslocamento; um aliado a até 9 m também pode (própria Reação). Nenhum movimento provoca Ataques de Oportunidade.',
  };
}

export async function resolveCoordinatedMovement(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 6, 'Bardo', 'Movimento Coordenado');
  const die = bardicInspirationDie(character.level, await bardBands(deps, character));
  const result = rollDamageParts(`1${die}`, 0);
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Movimento Coordenado',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Movimento Coordenado: na iniciativa, gaste 1 Inspiração — você e aliados a 9 m que possam ver/ouvir você somam +${result.total} (${result.expression}) à iniciativa.`,
  };
}

export async function resolveUnarmedDance(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 3, 'Bardo', 'Dança Virtuosa (Ataque Desarmado)');
  const die = bardicInspirationDie(character.level, await bardBands(deps, character));
  const dexterity = abilityModifier(character.abilityScores.destreza);
  const result = rollDamageParts(`1${die}`, dexterity);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Dança Virtuosa (Ataque Desarmado)',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Ataque Desarmado (Dança): usa Destreza no ataque; dano Contundente ${result.total} (${result.expression} = dado de Inspiração + DES, sem gastar uso).`,
  };
}

/** Colégio do Conhecimento — único resolve; fica aqui pelo limite leaf ≤4. */
export async function resolvePeerlessSkill(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'lore', 'Colégio do Conhecimento');
  assertCharacterLevel(character, 14, 'Bardo', 'Perícia Inigualável');
  const die = bardicInspirationDie(character.level, await bardBands(deps, character));
  const result = rollDamageParts(`1${die}`, 0);
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Perícia Inigualável',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Perícia Inigualável: após falhar teste ou ataque, some +${result.total} (${result.expression}) ao d20. Se ainda falhar, devolva o uso de Inspiração (± na Economia).`,
  };
}
