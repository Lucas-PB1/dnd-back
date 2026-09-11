import { BadRequestException } from '@nestjs/common';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import type {
  UseManeuverResponseDto,
} from '@game/session/dto/core/session-commands.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export async function applyGunslingerManeuverTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  maneuverSlug: string;
}): Promise<UseManeuverResponseDto> {
  if (!input.maneuverSlug?.trim()) {
    throw new BadRequestException('maneuverSlug é obrigatório');
  }
  return input.state.martial.useManeuver(
    input.character,
    input.maneuverSlug.trim(),
  );
}

export async function applyReloadFirearmTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  itemSlug: string;
}): Promise<TableActionResponseDto> {
  const state = await input.state.martial.reloadFirearm(
    input.character,
    input.itemSlug,
  );
  return {
    state,
    actionName: 'Recarregar',
    resourceSpent: false,
    note: `Recarregou ${input.itemSlug}.`,
  };
}

export async function applyFireChamberTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  itemSlug: string;
  shots: number;
}): Promise<TableActionResponseDto> {
  const state = await input.state.martial.fireChamber(
    input.character,
    input.itemSlug,
    input.shots,
  );
  return {
    state,
    actionName: 'Disparar',
    resourceSpent: false,
    note: `Gastou ${input.shots} tiro(s) de ${input.itemSlug}.`,
  };
}
