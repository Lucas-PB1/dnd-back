import {
  portentDiceCount,
  THIRD_EYE_RESOURCE,
} from '@game/combat/domain/wizard';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  WizardActionDeps,
  WizardTableActionResult,
} from './wizard-action-deps';

export async function resolvePortent(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'diviner', 'Escola de Adivinhação');
  assertCharacterLevel(character, 3, 'Mago', 'Presságio');
  const count = portentDiceCount(character.level);
  const rolls = Array.from(
    { length: count },
    () => Math.floor(Math.random() * 20) + 1,
  );

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Presságio',
    resourceSpent: false,
    note: `Presságio: rolagens de portento guardadas para hoje: [${rolls.join(', ')}]. Use para substituir qualquer d20 seu ou de uma criatura.`,
  };
}

export async function resolveThirdEye(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'diviner', 'Escola de Adivinhação');
  assertCharacterLevel(character, 10, 'Mago', 'O Terceiro Olho');
  const state = (
    await deps.state.useClassResource(character, THIRD_EYE_RESOURCE, 1)
  ).state;

  return {
    state,
    actionName: 'O Terceiro Olho',
    resourceSpent: true,
    note: 'O Terceiro Olho: Ação Bônus — escolha Compreensão Superior, Ver o Invisível (sem espaço) ou Visão no Escuro 36 m até o próximo descanso. 1× por Descanso Curto ou Longo.',
  };
}
