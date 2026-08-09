import { BadRequestException } from '@nestjs/common';
import {
  sorceryPointCostToCreateSlot,
  type MetamagicCatalogRow,
} from '@game/combat/domain/sorcerer';
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

export async function useMetamagicOption(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  option: MetamagicCatalogRow,
  knownSlugs: readonly string[],
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 2, 'Feiticeiro', 'Metamagia');
  if (knownSlugs.length > 0 && !knownSlugs.includes(option.slug)) {
    throw new BadRequestException(
      `Você não conhece a Metamagia '${option.name}'`,
    );
  }

  const state = await spendPoints(deps, character, option.cost);
  return {
    state,
    actionName: option.name,
    resourceSpent: true,
    total: option.cost,
    note: `Metamagia — ${option.name} (${option.cost} pt): ${option.description}`,
  };
}
