import { ForbiddenException } from '@nestjs/common';
import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { rollD20Check } from '@game/dice/domain/dice';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { CampaignRole } from '../infrastructure/campaign-member.entity';
import type { RollEncounterInitiativeDto } from '../dto/encounter.dto';

export async function applyCombatantInitiativeRoll(input: {
  rolls: CharacterRollsService;
  encounters: CampaignEncounterRepository;
  userId: string;
  combatant: CampaignEncounterCombatant;
  dto: RollEncounterInitiativeDto;
}): Promise<void> {
  const { combatant, dto } = input;
  if (combatant.kind === 'pc' && combatant.characterId) {
    const roll = await input.rolls.rollInitiative(
      input.userId,
      combatant.characterId,
      { advantage: dto.advantage },
    );
    combatant.initiativeTotal = roll.total;
    combatant.initiativeModifier = roll.modifier;
  } else {
    const modifier = combatant.initiativeModifier ?? 0;
    const roll = rollD20Check(modifier, dto.advantage ?? 'normal');
    combatant.initiativeTotal = roll.total;
    combatant.initiativeModifier = modifier;
  }
  await input.encounters.saveCombatant(combatant);
}

export async function assertCanRollInitiative(input: {
  campaigns: CampaignRepository;
  userId: string;
  role: CampaignRole;
  combatant: CampaignEncounterCombatant;
}): Promise<void> {
  if (input.role === 'dm' || input.role === 'assistant') return;
  if (input.combatant.kind !== 'pc' || !input.combatant.characterId) {
    throw new ForbiddenException('Players may only roll for their own PCs');
  }
  const [character] = await input.campaigns.findCharactersByIds([
    input.combatant.characterId,
  ]);
  if (!character || character.userId !== input.userId) {
    throw new ForbiddenException(
      'Players may only roll initiative for their own characters',
    );
  }
}
