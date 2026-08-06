import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import type { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import type {
  FighterTableActionResponseDto,
  UsePaladinTableActionDto,
} from '../../../dto/character-state.dto';
import type { CharacterStateRepository } from '../../../infrastructure/character-state.repository';
import type { PlayerCharacterAccessService } from '../../../../shared/player-character-access.service';

export type PaladinActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type PaladinTableActionResult = FighterTableActionResponseDto;
export type { PlayerCharacter, UsePaladinTableActionDto };

export const LAY_ON_HANDS_SLUG = 'layOnHands';
export const CHANNEL_DIVINITY_SLUG = 'channelDivinity';
export const CURE_POISON_COST = 5;

export async function paladinSaveDc(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const pb = await deps.domain.getProficiencyBonus(character.level);
  return 8 + abilityModifier(character.abilityScores.carisma) + pb;
}
