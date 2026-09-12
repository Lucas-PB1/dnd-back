import { BadRequestException } from '@nestjs/common';
import {
  assertValidPersonaMasks,
  maxEquippedPersonaMasks,
} from '@game/combat/domain/bard';
import {
  featureSchedulesFromCatalog,
} from '@game/combat/domain/feature-schedule';
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

  const catalog = await input.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    input.character.classSlug,
    input.character.subclassSlug,
  );

  try {
    assertValidPersonaMasks(
      catalog.personaMaskSlugs,
      input.masks,
      input.character.level,
      bands,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid persona masks',
    );
  }

  const max = maxEquippedPersonaMasks(input.character.level, bands);
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
