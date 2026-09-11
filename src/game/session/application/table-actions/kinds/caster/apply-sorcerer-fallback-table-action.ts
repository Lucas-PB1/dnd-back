import { BadRequestException } from '@nestjs/common';
import { INNATE_SORCERY_RESOURCE } from '@game/combat/domain/sorcerer';

const DRAGON_WINGS_RESOURCE = 'dragon-wings';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../primitives/table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const SORCERY_POINTS_SLUG = 'sorceryPoints';

async function remainingResource(
  state: CharacterStateRepository,
  character: PlayerCharacter,
  slug: string,
): Promise<number> {
  const response = await state.buildResponse(character);
  return (
    response.classResources.find((resource) => resource.slug === slug)
      ?.remaining ?? 0
  );
}

export async function applyInnateSorceryTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
}): Promise<TableActionResponseDto> {
  assertCharacterLevel(input.character, 1, 'Feiticeiro', 'Feitiçaria Inata');
  const innateLeft = await remainingResource(
    input.state,
    input.character,
    INNATE_SORCERY_RESOURCE,
  );

  let spentNote: string;
  if (innateLeft > 0) {
    await input.state.useClassResource(
      input.character,
      INNATE_SORCERY_RESOURCE,
      1,
    );
    spentNote = '1 uso';
  } else if (input.character.level >= 7) {
    await input.state.useClassResource(
      input.character,
      SORCERY_POINTS_SLUG,
      2,
    );
    spentNote = 'Feitiçaria Encarnada: 2 Pontos de Feitiçaria';
  } else {
    throw new BadRequestException(
      'Sem usos de Feitiçaria Inata (recupera no Descanso Longo)',
    );
  }

  return {
    state: await input.state.buildResponse(input.character),
    actionName: 'Feitiçaria Inata',
    resourceSpent: true,
    note: `Feitiçaria Inata (${spentNote}): Ação Bônus libera a magia por 1 minuto (+1 na CD das suas magias de Feiticeiro e Vantagem nas jogadas de ataque das magias de Feiticeiro).`,
  };
}

export async function applyDragonWingsTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
}): Promise<TableActionResponseDto> {
  assertCharacterSubclass(input.character, 'draconic', 'Linhagem Dracônica');
  assertCharacterLevel(input.character, 14, 'Feiticeiro', 'Asas de Dragão');

  const wingsLeft = await remainingResource(
    input.state,
    input.character,
    DRAGON_WINGS_RESOURCE,
  );

  let spentNote: string;
  if (wingsLeft > 0) {
    await input.state.useClassResource(
      input.character,
      DRAGON_WINGS_RESOURCE,
      1,
    );
    spentNote = '1 uso';
  } else {
    await input.state.useClassResource(
      input.character,
      SORCERY_POINTS_SLUG,
      3,
    );
    spentNote = '3 Pontos de Feitiçaria (restaurou o uso)';
  }

  return {
    state: await input.state.buildResponse(input.character),
    actionName: 'Asas de Dragão',
    resourceSpent: true,
    note: `Asas de Dragão (${spentNote}): Ação Bônus — asas por 1 hora; Deslocamento de Voo 18 m.`,
  };
}
