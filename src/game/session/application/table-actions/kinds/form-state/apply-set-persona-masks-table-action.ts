import { BadRequestException } from '@nestjs/common';
import {
  assertValidPersonaMasks,
  maxEquippedPersonaMasks,
} from '@game/combat/domain/bard';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { assertCharacterLevel } from '../../primitives/table-action-guards';

export async function applySetPersonaMasksTableAction(input: {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  character: PlayerCharacter;
  actionName: string;
  masks: string[];
}): Promise<TableActionResponseDto> {
  assertCharacterLevel(input.character, 3, 'Bardo', 'Máscaras de Persona');
  if (input.character.subclassSlug !== 'college-of-masks') {
    throw new BadRequestException('Máscaras de Persona exige Colégio das Máscaras');
  }

  try {
    const catalog = await input.mechanicalCatalog.load();
    assertValidPersonaMasks(
      catalog.personaMaskSlugs,
      input.masks,
      input.character.level,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid persona masks',
    );
  }

  const max = maxEquippedPersonaMasks(input.character.level);
  const state = await input.state.martial.setPersonaMasks(
    input.character,
    input.masks,
  );
  const label =
    input.masks.length === 0 ? 'nenhuma máscara' : input.masks.join(', ');

  return {
    state,
    actionName: input.actionName,
    resourceSpent: false,
    note: `Máscaras de Persona (${input.masks.length}/${max}): ${label}.`,
  };
}
