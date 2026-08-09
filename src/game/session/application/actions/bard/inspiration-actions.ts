import { bardicInspirationDie } from '@game/combat/domain/bard';
import { rollDamageParts } from '@game/dice/domain/dice';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BardActionDeps,
  BardTableActionResult,
  PlayerCharacter,
} from './bard-action-deps';
import {
  BARDIC_INSPIRATION_SLUG,
  spendInspiration,
} from './bard-action-deps';

export async function resolveGrantInspiration(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterLevel(character, 1, 'Bardo', 'Inspiração de Bardo');
  const die = bardicInspirationDie(character.level);
  const state = await spendInspiration(deps, character);

  return {
    state,
    actionName: 'Inspiração de Bardo',
    expression: `1${die}`,
    resourceSpent: true,
    note: `Inspiração de Bardo (1${die}): concedida como Ação Bônus a uma criatura voluntária a até 18 m por 1 hora. Ela pode adicionar o dado a um teste de habilidade, ataque ou salvaguarda.`,
  };
}

export async function resolveCuttingWords(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'lore', 'Colégio do Conhecimento');
  assertCharacterLevel(character, 3, 'Bardo', 'Palavras de Interrupção');
  const die = bardicInspirationDie(character.level);
  const result = rollDamageParts(`1${die}`, 0);
  const state = await spendInspiration(deps, character);

  return {
    state,
    actionName: 'Palavras de Interrupção',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Palavras de Interrupção: Reação gasta 1 Inspiração para subtrair ${result.total} (1${die}) de uma jogada de ataque, teste de habilidade ou dano de um inimigo visível a até 18 m.`,
  };
}

export async function resolveCombatInspiration(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'valor', 'Colégio da Bravura');
  assertCharacterLevel(character, 3, 'Bardo', 'Inspiração em Combate');
  const die = bardicInspirationDie(character.level);
  const state = await spendInspiration(deps, character);

  return {
    state,
    actionName: 'Inspiração em Combate',
    expression: `1${die}`,
    resourceSpent: true,
    note: `Inspiração em Combate (1${die}): a criatura com Inspiração de Bardo pode rolar o dado e somar à rolagem de dano da arma ou usar a Reação para somar o dado à sua CA contra um ataque.`,
  };
}

export async function resolveSuperiorInspiration(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterLevel(character, 18, 'Bardo', 'Inspiração Superior');
  const state = await deps.state.recoverClassResource(
    character,
    BARDIC_INSPIRATION_SLUG,
    1,
  );

  return {
    state,
    actionName: 'Inspiração Superior',
    resourceSpent: false,
    note: 'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração de Bardo restantes, recupere 1 uso.',
  };
}
