import {
  DARK_ONES_LUCK_RESOURCE,
  MAGICAL_CUNNING_RESOURCE,
  magicalCunningSlotRecoveryCount,
  warlockPactSlotLevel,
} from '@game/combat/domain/warlock-features';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type { WarlockTableActionResult } from './warlock-action-deps';
import type { PlayerCharacter, WarlockActionDeps } from './warlock-action-deps';

export async function resolveMagicalCunning(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterLevel(character, 2, 'Bruxo', 'Astúcia Mágica');
  const slotLvl = warlockPactSlotLevel(character.level);
  const recoverCount = magicalCunningSlotRecoveryCount(character.level);

  await deps.state.useClassResource(
    character,
    MAGICAL_CUNNING_RESOURCE,
    1,
  );
  for (let i = 0; i < recoverCount; i += 1) {
    await deps.state.recoverSpellSlotLevel(character, slotLvl);
  }

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Astúcia Mágica',
    resourceSpent: true,
    note: `Astúcia Mágica: recuperou ${recoverCount} Slot(s) de Pacto de ${slotLvl}º círculo (1×/Descanso Longo).`,
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
  assertCharacterLevel(character, 6, 'Bruxo', 'A Sorte do Próprio Tenebroso');
  const result = rollDamageParts('1d10', 0);

  let state;
  try {
    state = (
      await deps.state.useClassResource(character, DARK_ONES_LUCK_RESOURCE, 1)
    ).state;
  } catch {
    state = await deps.state.buildResponse(character);
  }

  return {
    state,
    actionName: 'A Sorte do Próprio Tenebroso',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `A Sorte do Próprio Tenebroso: some +${result.total} (1d10) ao teste de habilidade ou salvaguarda que você acabou de rolar.`,
  };
}
