import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseClericTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';

import { CHANNEL_DIVINITY_SLUG } from '@game/session/domain/resource-slugs';

export { CHANNEL_DIVINITY_SLUG };

export type ClericActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type ClericTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseClericTableActionDto };

export function assertSubclassFeature(
  character: PlayerCharacter,
  subclassSlug: string,
  subclassName: string,
  featureName: string,
  minLevel = 3,
): void {
  assertCharacterSubclass(character, subclassSlug, subclassName);
  assertCharacterLevel(character, minLevel, 'Clérigo', featureName);
}

export async function spendChannelDivinity(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<TableActionResponseDto['state']> {
  return (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
}

export async function spellSaveDc(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const proficiency = await deps.domain.getProficiencyBonus(character.level);
  return 8 + proficiency + abilityModifier(character.abilityScores.sabedoria);
}
