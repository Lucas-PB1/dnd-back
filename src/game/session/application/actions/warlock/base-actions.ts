import {
  warlockPactSlotLevel,
} from '../../../../combat/domain/warlock-features';
import { rollDamageParts } from '../../../../dice/domain/dice';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../core/table-action-guards';
import type { WarlockTableActionResult } from './warlock-action-deps';
import type { PlayerCharacter, WarlockActionDeps } from './warlock-action-deps';

export async function resolveMagicalCunning(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterLevel(character, 5, 'Bruxo', 'Contato Arcano');
  const slotLvl = warlockPactSlotLevel(character.level);
  await deps.state.recoverSpellSlotLevel(character, slotLvl);
  const updatedState = await deps.state.buildResponse(character);

  return {
    state: updatedState,
    actionName: 'Contato Arcano',
    resourceSpent: true,
    note: `Contato Arcano: Ação Bônus recuperou 1 Slot de Pacto de ${slotLvl}º círculo (1×/Descanso Longo).`,
  };
}

export async function resolveHealingLight(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'celestial', 'Patrono Celestial');
  assertCharacterLevel(character, 3, 'Bruxo', 'Luz Curativa');
  const charisma = abilityModifier(character.abilityScores.carisma);
  const diceCount = Math.max(1, charisma);
  const result = rollDamageParts(`${diceCount}d6`, 0);

  let state;
  try {
    state = (
      await deps.state.useClassResource(character, 'healing-light', diceCount)
    ).state;
  } catch {
    state = await deps.state.buildResponse(character);
  }

  return {
    state,
    actionName: 'Luz Curativa',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Luz Curativa: Ação Bônus gasta ${diceCount}d6 da reserva e restaura ${result.total} PV (${result.expression}) a uma criatura visível a até 18 m.`,
  };
}

export async function resolveDarkOnesOwnLuck(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'fiend', 'Patrono Ínfero');
  assertCharacterLevel(character, 3, 'Bruxo', 'Sorte do Próprio Inferno');
  const result = rollDamageParts('1d10', 0);

  let state;
  try {
    state = (
      await deps.state.useClassResource(character, 'dark-ones-own-luck', 1)
    ).state;
  } catch {
    state = await deps.state.buildResponse(character);
  }

  return {
    state,
    actionName: 'Sorte do Próprio Inferno',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Sorte do Próprio Inferno: some +${result.total} (1d10) ao teste de habilidade ou salvaguarda que você acabou de rolar.`,
  };
}
