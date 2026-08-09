import { BadRequestException } from '@nestjs/common';
import { bardicInspirationDie } from '@game/combat/domain/bard';
import {
  assertValidPersonaMasks,
  maxEquippedPersonaMasks,
} from '@game/combat/domain/bard';
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
} from './bard-action-deps';
import { spendInspiration } from './bard-action-deps';

export async function resolveEnthrallingPerformance(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'glamour', 'Colégio do Glamour');
  assertCharacterLevel(character, 3, 'Bardo', 'Desempenho Cativante');
  const die = bardicInspirationDie(character.level);
  const result = rollDamageParts(`2${die}`, 0);
  const charisma = abilityModifier(character.abilityScores.carisma);
  const alliesCount = Math.max(1, charisma);
  const state = await spendInspiration(deps, character);

  return {
    state,
    actionName: 'Desempenho Cativante',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Desempenho Cativante: gaste 1 Inspiração para conceder ${result.total} PV temporários (${result.expression}) a até ${alliesCount} aliados a 18 m. Cada um pode usar a Reação para mover-se seu Deslocamento sem provocar ataques de oportunidade.`,
  };
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

export async function resolveUnarmedDance(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 3, 'Bardo', 'Dança Virtuosa (Ataque Desarmado)');
  const die = bardicInspirationDie(character.level);
  const charisma = abilityModifier(character.abilityScores.carisma);
  const result = rollDamageParts(`1${die}`, charisma);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Dança Virtuosa (Ataque Desarmado)',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Ataque Desarmado Dançante: usa Carisma no ataque/dano e causa ${result.total} de dano Contundente (${result.expression}). Ao usar Ação Bônus, pode mover-se sem provocar ataques de oportunidade.`,
  };
}

export async function resolveSetPersonaMasks(
  deps: BardActionDeps,
  character: PlayerCharacter,
  masks: string[],
): Promise<BardTableActionResult> {
  assertCharacterSubclass(
    character,
    'college-of-masks',
    'Colégio das Máscaras',
  );
  assertCharacterLevel(character, 3, 'Bardo', 'Máscaras de Persona');
  try {
    const catalog = await deps.mechanicalCatalog.load();
    assertValidPersonaMasks(
      catalog.personaMaskSlugs,
      masks,
      character.level,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid persona masks',
    );
  }

  const max = maxEquippedPersonaMasks(character.level);
  const state = await deps.state.martial.setPersonaMasks(character, masks);
  const label = masks.length === 0 ? 'nenhuma máscara' : masks.join(', ');

  return {
    state,
    actionName: 'Vestir Máscaras de Persona',
    resourceSpent: false,
    note: `Máscaras de Persona (${masks.length}/${max}): ${label}.`,
  };
}
