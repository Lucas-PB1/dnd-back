import { BadRequestException } from '@nestjs/common';
import { assertCharacterLevel } from './table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export async function applyWildResurgenceTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  actionSlug: string;
}): Promise<TableActionResponseDto> {
  assertCharacterLevel(input.character, 5, 'Druida', 'Ressurgimento Selvagem');

  if (input.actionSlug === 'wild-resurgence-slot') {
    await input.state.useClassResource(input.character, 'wildShape', 1);
    await input.state.recoverSpellSlotLevel(input.character, 1);
    const state = await input.state.buildResponse(input.character);
    return {
      state,
      actionName: 'Ressurgimento Selvagem (Slot)',
      resourceSpent: true,
      note: 'Ressurgimento Selvagem: gastou 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo.',
    };
  }

  if (input.actionSlug === 'wild-resurgence-shape') {
    await input.state.consumeSpellSlotLevel(input.character, 1);
    const state = await input.state.recoverClassResource(
      input.character,
      'wildShape',
      1,
    );
    return {
      state,
      actionName: 'Ressurgimento Selvagem (Forma)',
      resourceSpent: true,
      note: 'Ressurgimento Selvagem: consumiu 1 Slot de 1º círculo para recuperar 1 uso de Forma Selvagem.',
    };
  }

  throw new BadRequestException(
    `Ressurgimento Selvagem desconhecido: ${input.actionSlug}`,
  );
}

export async function applyRestoreLunarStepTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  slotLevel?: number;
}): Promise<TableActionResponseDto> {
  const level = input.slotLevel ?? 2;
  if (level < 2) {
    throw new BadRequestException(
      'Restaurar Passo Lunar exige espaço de 2º círculo ou superior',
    );
  }
  await input.state.consumeSpellSlotLevel(input.character, level);
  const state = await input.state.recoverClassResource(
    input.character,
    'lunar-step',
    1,
  );
  return {
    state,
    actionName: 'Restaurar Passo Lunar',
    resourceSpent: true,
    note: `Restaurou 1 uso de Passo Lunar gastando 1 espaço de ${level}º círculo.`,
  };
}

export async function applyMoonCombatWildShapeTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
}): Promise<TableActionResponseDto> {
  const { moonWildShapeTempHp } = await import('@game/combat/domain/druid');
  const tempHp = moonWildShapeTempHp(input.character.level);
  const crMax = Math.floor(input.character.level / 3);
  await input.state.useClassResource(input.character, 'wildShape', 1);
  const state = await input.state.patch(input.character, { tempHp });

  return {
    state,
    actionName: 'Forma Selvagem de Combate',
    resourceSpent: true,
    total: tempHp,
    note: `Forma Selvagem de Combate: ${tempHp} PV temp. (ficha), CA 13+SAB se maior, ND máx. ${crMax}. Ficha de besta = futuro.`,
  };
}
