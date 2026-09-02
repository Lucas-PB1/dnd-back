import type { CampaignSummaryDto, CampaignMemberDto } from '../../dto/campaign.dto';
import type { Campaign } from '../../infrastructure/campaign.entity';
import type { CampaignMember, CampaignRole } from '../../infrastructure/campaign-member.entity';
import type { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import type { resolveAuthUserProfiles } from '../resolve-auth-user-profiles';

type AuthProfiles = Awaited<ReturnType<typeof resolveAuthUserProfiles>>;

export function toMemberDto(
  member: CampaignMember,
  profiles: AuthProfiles,
  characters: PlayerCharacter[],
): CampaignMemberDto {
  const profile = profiles.get(member.userId);
  return {
    userId: member.userId,
    role: member.role,
    joinedAt: member.joinedAt.toISOString(),
    displayName: profile?.displayName ?? null,
    email: profile?.email ?? null,
    avatarUrl: profile?.avatarUrl ?? null,
    bio: profile?.bio ?? null,
    characterNames: characters
      .filter((character) => character.userId === member.userId)
      .map((character) => character.name)
      .filter(Boolean),
  };
}

export function toSummary(
  campaign: Campaign,
  role: CampaignRole,
): CampaignSummaryDto {
  return {
    id: campaign.id,
    name: campaign.name,
    description: campaign.description,
    inviteCode: campaign.inviteCode,
    myRole: role,
    allowPlayerSkipPayment: campaign.allowPlayerSkipPayment,
    createdAt: campaign.createdAt.toISOString(),
    updatedAt: campaign.updatedAt.toISOString(),
  };
}

export function toLinkedCharacterDto(
  link: { characterId: string; linkedAt: Date },
  character: PlayerCharacter | undefined,
) {
  return {
    characterId: link.characterId,
    name: character?.name ?? '',
    level: character?.level ?? 0,
    classSlug: character?.classSlug ?? '',
    speciesSlug: character?.speciesSlug ?? '',
    linkedAt: link.linkedAt.toISOString(),
  };
}
