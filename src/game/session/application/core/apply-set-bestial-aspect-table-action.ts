import { BadRequestException } from '@nestjs/common';
import {
  bestialAspectBenefits,
  clampBestialAspectLevel,
} from '@game/combat/domain/ranger';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

export async function applySetBestialAspectTableAction(input: {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  character: PlayerCharacter;
  actionName: string;
  level: number | undefined;
}): Promise<TableActionResponseDto> {
  assertCharacterSubclass(input.character, 'beastborne', 'Beastborne');
  assertCharacterLevel(input.character, 3, 'Patrulheiro', 'Aspecto Bestial');
  if (input.level === undefined) {
    throw new BadRequestException('Bestial aspect level is required');
  }

  const clamped = clampBestialAspectLevel(input.level);
  const state = await input.state.martial.setBestialAspectLevel(
    input.character,
    clamped,
  );
  const catalog = await input.mechanicalCatalog.load();
  const benefits = bestialAspectBenefits(
    catalog.beastborneAspectBenefits,
    clamped,
  );
  const benefitNote =
    benefits.length > 0
      ? ` Benefícios: ${benefits.map((b) => b.split(':')[0]).join(', ')}.`
      : '';

  return {
    state,
    actionName: input.actionName,
    resourceSpent: false,
    note: `Aspecto Bestial definido em ${clamped}.${benefitNote}`,
  };
}
