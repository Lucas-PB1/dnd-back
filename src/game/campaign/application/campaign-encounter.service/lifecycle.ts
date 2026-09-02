import { BadRequestException } from '@nestjs/common';
import type { CampaignRepository } from '../../infrastructure/campaign.repository';
import type { CampaignEncounterRepository } from '../../infrastructure/campaign-encounter.repository';
import type { LoadEncounterDto } from '../load-encounter-dto';
import {
  assertPlayerCanViewEncounter,
  viewerFromMember,
} from '../encounter-combatant-ops';
import { requireActiveEncounter } from '../require-active-encounter';
import type {
  CampaignEncounterDto,
  CreateCampaignEncounterDto,
  PatchCampaignEncounterDto,
} from '../../dto/encounter.dto';

export type EncounterLifecycleDeps = {
  campaigns: CampaignRepository;
  encounters: CampaignEncounterRepository;
  loadDto: LoadEncounterDto;
};

export async function createEncounter(
  deps: EncounterLifecycleDeps,
  userId: string,
  campaignId: string,
  dto: CreateCampaignEncounterDto,
): Promise<CampaignEncounterDto> {
  await deps.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
  const links = await deps.campaigns.listLinkedCharacters(campaignId);
  const encounter = await deps.encounters.createActive({
    campaignId,
    name: dto.name,
    createdBy: userId,
    characterIds: links.map((link) => link.characterId),
  });
  return deps.loadDto.load(encounter, 'dm');
}

export async function getActiveEncounter(
  deps: EncounterLifecycleDeps,
  userId: string,
  campaignId: string,
) {
  const member = await deps.campaigns.requireMember(campaignId, userId);
  const encounter = await deps.encounters.findActiveOrFail(campaignId);
  assertPlayerCanViewEncounter(member, encounter);
  return deps.loadDto.load(encounter, viewerFromMember(member));
}

export async function getEncounter(
  deps: EncounterLifecycleDeps,
  userId: string,
  campaignId: string,
  encounterId: string,
) {
  const member = await deps.campaigns.requireMember(campaignId, userId);
  const encounter = await deps.encounters.findEncounterInCampaignOrFail(
    campaignId,
    encounterId,
  );
  assertPlayerCanViewEncounter(member, encounter);
  return deps.loadDto.load(encounter, viewerFromMember(member));
}

export async function patchEncounter(
  deps: EncounterLifecycleDeps,
  userId: string,
  campaignId: string,
  encounterId: string,
  dto: PatchCampaignEncounterDto,
): Promise<CampaignEncounterDto> {
  await deps.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
  const encounter = await requireActiveEncounter(
    deps.encounters,
    campaignId,
    encounterId,
  );
  if (dto.name !== undefined) encounter.name = dto.name.trim();
  if (dto.playersCanView !== undefined) {
    encounter.playersCanView = dto.playersCanView;
  }
  if (dto.creatureHpVisibility !== undefined) {
    encounter.creatureHpVisibility = dto.creatureHpVisibility;
  }
  await deps.encounters.saveEncounter(encounter);
  return deps.loadDto.load(encounter, 'dm');
}

export async function closeEncounter(
  deps: EncounterLifecycleDeps,
  userId: string,
  campaignId: string,
  encounterId: string,
) {
  await deps.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
  const encounter = await deps.encounters.findEncounterInCampaignOrFail(
    campaignId,
    encounterId,
  );
  if (encounter.status === 'closed') {
    throw new BadRequestException('Encounter is already closed');
  }
  encounter.status = 'closed';
  await deps.encounters.saveEncounter(encounter);
  return deps.loadDto.load(encounter, 'dm');
}
