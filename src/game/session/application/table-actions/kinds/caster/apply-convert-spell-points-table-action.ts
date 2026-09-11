import { BadRequestException } from '@nestjs/common';
import {
  sorceryPointCostToCreateSlot,
} from '@game/combat/domain/sorcerer';
import { assertCharacterLevel } from '../../primitives/table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const SORCERY_POINTS_SLUG = 'sorceryPoints';

export async function applyConvertSpellPointsTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  actionSlug: string;
}): Promise<TableActionResponseDto> {
  const { character, actionSlug } = input;
  assertCharacterLevel(character, 2, 'Feiticeiro', 'Fonte de Magia');

  const slotToPoints = actionSlug.match(/^convert-slot-(\d)-to-points$/);
  if (slotToPoints) {
    const slotLevel = Number(slotToPoints[1]);
    await input.state.consumeSpellSlotLevel(character, slotLevel);
    const state = await input.state.recoverClassResource(
      character,
      SORCERY_POINTS_SLUG,
      slotLevel,
    );
    return {
      state,
      actionName: `Converter Slot de ${slotLevel}º Círculo`,
      resourceSpent: true,
      total: slotLevel,
      note: `Fonte de Magia: consumiu 1 Slot de ${slotLevel}º círculo para recuperar ${slotLevel} Pontos de Feitiçaria.`,
    };
  }

  const pointsToSlot = actionSlug.match(/^convert-points-to-slot-(\d)$/);
  if (pointsToSlot) {
    const slotLevel = Number(pointsToSlot[1]);
    const cost = sorceryPointCostToCreateSlot(slotLevel);
    const spent = await input.state.useClassResource(
      character,
      SORCERY_POINTS_SLUG,
      cost,
    );
    await input.state.recoverSpellSlotLevel(character, slotLevel);
    const state = await input.state.buildResponse(character);
    return {
      state,
      actionName: `Criar Slot de ${slotLevel}º Círculo`,
      resourceSpent: true,
      total: cost,
      note: `Fonte de Magia: gastou ${cost} Pontos de Feitiçaria para criar 1 Slot de ${slotLevel}º círculo.`,
    };
  }

  throw new BadRequestException(`Conversão Fonte de Magia desconhecida: ${actionSlug}`);
}
