import { sorceryPointCostToCreateSlot } from '@game/combat/domain/sorcerer-features';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  SorcererActionDeps,
  SorcererTableActionResult,
} from './sorcerer-action-deps';
import { SORCERY_POINTS_SLUG, spendPoints } from './sorcerer-action-deps';

export async function convertSlotToPoints(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  slotLevel: number,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 2, 'Feiticeiro', 'Fonte de Magia');
  await deps.state.consumeSpellSlotLevel(character, slotLevel);
  const updatedState = await deps.state.recoverClassResource(
    character,
    SORCERY_POINTS_SLUG,
    slotLevel,
  );

  return {
    state: updatedState,
    actionName: `Converter Slot de ${slotLevel}º Círculo`,
    resourceSpent: true,
    total: slotLevel,
    note: `Fonte de Magia: consumiu 1 Slot de ${slotLevel}º círculo para recuperar ${slotLevel} Pontos de Feitiçaria.`,
  };
}

export async function convertPointsToSlot(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  slotLevel: number,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 2, 'Feiticeiro', 'Fonte de Magia');
  const cost = sorceryPointCostToCreateSlot(slotLevel);
  await spendPoints(deps, character, cost);
  await deps.state.recoverSpellSlotLevel(character, slotLevel);
  const updatedState = await deps.state.buildResponse(character);

  return {
    state: updatedState,
    actionName: `Criar Slot de ${slotLevel}º Círculo`,
    resourceSpent: true,
    total: cost,
    note: `Fonte de Magia: gastou ${cost} Pontos de Feitiçaria para criar 1 Slot de ${slotLevel}º círculo.`,
  };
}

export async function useMetamagic(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  pointsCost: number,
  label: string,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 2, 'Feiticeiro', 'Metamágica');
  const state = await spendPoints(deps, character, pointsCost);

  return {
    state,
    actionName: label,
    resourceSpent: true,
    total: pointsCost,
    note: `Metamágica: gastou ${pointsCost} Ponto(s) de Feitiçaria para modificar a conjuração da magia.`,
  };
}
