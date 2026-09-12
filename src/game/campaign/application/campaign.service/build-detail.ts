import type { DataSource } from 'typeorm';
import type { CampaignRepository } from '../../infrastructure/campaign.repository';
import type { CampaignDetailDto } from '../../dto/campaign.dto';
import { resolveAuthUserProfiles } from '../resolve-auth-user-profiles';
import { toMemberDto, toSummary } from './to-dto';

export async function buildCampaignDetail(
  repo: CampaignRepository,
  dataSource: DataSource,
  userId: string,
  campaignId: string,
): Promise<CampaignDetailDto> {
  const membership = await repo.requireMember(campaignId, userId);
  const campaign = await repo.findCampaignOrFail(campaignId);
  const members = await repo.listMembers(campaignId);
  const links = await repo.listLinkedCharacters(campaignId);
  const characters = await repo.findCharactersByIds(
    links.map((l) => l.characterId),
  );
  const byId = new Map(characters.map((c) => [c.id, c]));
  const profiles = await resolveAuthUserProfiles(
    dataSource,
    members.map((m) => m.userId),
  );

  return {
    ...toSummary(campaign, membership.role),
    members: members.map((m) => toMemberDto(m, profiles, characters)),
    characters: links.map((link) => {
      const character = byId.get(link.characterId);
      return {
        characterId: link.characterId,
        name: character?.name ?? '(removido)',
        level: character?.level ?? 0,
        classSlug: character?.classSlug ?? '',
        speciesSlug: character?.speciesSlug ?? '',
        linkedAt: link.linkedAt.toISOString(),
      };
    }),
  };
}
