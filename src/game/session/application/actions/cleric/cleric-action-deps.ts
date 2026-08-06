import { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseClericTableActionDto,
} from '../../../dto/character-state.dto';
import { CharacterStateRepository } from '../../../infrastructure/character-state.repository';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../core/table-action-guards';

export const CHANNEL_DIVINITY_SLUG = 'channelDivinity';

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
