import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  WizardActionDeps,
  WizardTableActionResult,
} from './wizard-action-deps';

export async function resolveArcaneRecovery(
  deps: WizardActionDeps,
  character: PlayerCharacter,
  slotLevel: number,
): Promise<WizardTableActionResult> {
  assertCharacterLevel(character, 1, 'Mago', 'Recuperação Arcana');
  await deps.state.recoverSpellSlotLevel(character, slotLevel);
  const updatedState = await deps.state.buildResponse(character);

  return {
    state: updatedState,
    actionName: `Recuperação Arcana (Slot ${slotLevel}º)`,
    resourceSpent: true,
    note: `Recuperação Arcana: recuperou 1 Slot de ${slotLevel}º círculo durante o descanso curto.`,
  };
}

export async function resolveSpellMastery(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterLevel(character, 18, 'Mago', 'Dominância de Magias');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Dominância de Magias',
    resourceSpent: false,
    note: 'Dominância de Magias: 1 magia de 1º círculo e 1 de 2º círculo preparadas podem ser conjuradas sem consumir espaço de magia.',
  };
}
