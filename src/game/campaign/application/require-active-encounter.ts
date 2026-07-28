import { BadRequestException } from '@nestjs/common';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';

export async function requireActiveEncounter(
  encounters: CampaignEncounterRepository,
  campaignId: string,
  encounterId: string,
): Promise<CampaignEncounter> {
  const encounter = await encounters.findEncounterInCampaignOrFail(
    campaignId,
    encounterId,
  );
  if (encounter.status !== 'active') {
    throw new BadRequestException('Encounter is closed');
  }
  return encounter;
}
