import { BadRequestException, ForbiddenException } from '@nestjs/common';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { CampaignRole } from '../infrastructure/campaign-member.entity';

export async function assertCanResolveEncounterAttack(input: {
  campaigns: CampaignRepository;
  userId: string;
  role: CampaignRole;
  attacker: CampaignEncounterCombatant;
  target: CampaignEncounterCombatant;
}): Promise<void> {
  if (input.attacker.id === input.target.id) {
    throw new BadRequestException('Attacker and target must be different combatants');
  }
  if (!input.attacker.isActive || !input.target.isActive) {
    throw new BadRequestException('Both combatants must be active');
  }
  if (input.role === 'dm' || input.role === 'assistant') return;
  if (input.attacker.kind !== 'pc' || !input.attacker.characterId) {
    throw new ForbiddenException('Players may only attack with their own PCs');
  }
  const [character] = await input.campaigns.findCharactersByIds([
    input.attacker.characterId,
  ]);
  if (!character || character.userId !== input.userId) {
    throw new ForbiddenException(
      'Players may only attack with their own characters',
    );
  }
}
