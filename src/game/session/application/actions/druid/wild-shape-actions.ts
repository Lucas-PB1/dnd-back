import { assertCharacterLevel } from '../../core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from './druid-action-deps';
import { recoverWildShape, spendWildShape } from './druid-action-deps';

export async function resolveWildShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterLevel(character, 2, 'Druida', 'Forma Selvagem');
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Forma Selvagem',
    resourceSpent: true,
    total: 1,
    note: 'Forma Selvagem: gastou 1 uso para assumir a forma de uma besta ou ativar Companheiro Selvagem.',
  };
}

export async function resolveWildResurgenceSlot(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterLevel(character, 5, 'Druida', 'Ressurgimento Selvagem');
  await spendWildShape(deps, character);
  await deps.state.recoverSpellSlotLevel(character, 1);
  const updatedState = await deps.state.buildResponse(character);

  return {
    state: updatedState,
    actionName: 'Ressurgimento Selvagem (Slot)',
    resourceSpent: true,
    note: 'Ressurgimento Selvagem: gastou 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo.',
  };
}

export async function resolveWildResurgenceShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterLevel(character, 5, 'Druida', 'Ressurgimento Selvagem');
  await deps.state.consumeSpellSlotLevel(character, 1);
  const updatedState = await recoverWildShape(deps, character);

  return {
    state: updatedState,
    actionName: 'Ressurgimento Selvagem (Forma)',
    resourceSpent: true,
    note: 'Ressurgimento Selvagem: consumiu 1 Slot de 1º círculo para recuperar 1 uso de Forma Selvagem.',
  };
}
