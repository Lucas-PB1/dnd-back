import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { Campaign } from '../campaign.entity';
import { CampaignCharacter } from '../campaign-character.entity';
import { CampaignMember } from '../campaign-member.entity';
import {
  CampaignMembershipDeps,
  requireMember,
} from './campaign-membership';

export type CampaignCharacterLinksDeps = CampaignMembershipDeps & {
  links: Repository<CampaignCharacter>;
  characterRows: Repository<PlayerCharacter>;
  characters: CharacterRepository;
};

export async function linkCharacter(
  deps: CampaignCharacterLinksDeps,
  campaignId: string,
  userId: string,
  characterId: string,
): Promise<CampaignCharacter> {
  await requireMember(deps, campaignId, userId);
  const character = await deps.characters.findOwnedOrFail(userId, characterId);

  const existing = await deps.links.findOne({
    where: { campaignId, characterId: character.id },
  });
  if (existing) return existing;

  return deps.links.save(
    deps.links.create({
      campaignId,
      characterId: character.id,
      linkedBy: userId,
    }),
  );
}

export async function unlinkCharacter(
  deps: CampaignCharacterLinksDeps,
  campaignId: string,
  userId: string,
  characterId: string,
): Promise<void> {
  const member = await requireMember(deps, campaignId, userId);
  const link = await deps.links.findOne({
    where: { campaignId, characterId },
  });
  if (!link) {
    throw new NotFoundException('Character is not linked to this campaign');
  }

  const owned = await deps.characterRows.findOne({
    where: { id: characterId, userId },
  });
  const canUnlink =
    Boolean(owned) ||
    member.role === 'dm' ||
    member.role === 'assistant' ||
    link.linkedBy === userId;

  if (!canUnlink) {
    throw new ForbiddenException(
      'Only owner, dm or assistant can unlink this character',
    );
  }

  await deps.links.remove(link);
}

export async function listLinkedCharacters(
  deps: CampaignCharacterLinksDeps,
  campaignId: string,
): Promise<CampaignCharacter[]> {
  return deps.links.find({
    where: { campaignId },
    order: { linkedAt: 'ASC' },
  });
}

export async function findCharactersByIds(
  deps: CampaignCharacterLinksDeps,
  ids: string[],
): Promise<PlayerCharacter[]> {
  if (ids.length === 0) return [];
  return deps.characterRows.find({ where: { id: In(ids) } });
}

/**
 * Mapa characterId → campanhas em que o personagem está vinculado
 * (inclui setting de skip payment e papel do viewer).
 */
export async function listCampaignRefsByCharacterIds(
  deps: {
    links: Repository<CampaignCharacter>;
    campaigns: Repository<Campaign>;
    members: Repository<CampaignMember>;
  },
  characterIds: string[],
  userId: string,
): Promise<
  Map<
    string,
    Array<{
      id: string;
      name: string;
      allowPlayerSkipPayment: boolean;
      myRole: 'dm' | 'player' | 'assistant' | null;
    }>
  >
> {
  const result = new Map<
    string,
    Array<{
      id: string;
      name: string;
      allowPlayerSkipPayment: boolean;
      myRole: 'dm' | 'player' | 'assistant' | null;
    }>
  >();
  if (characterIds.length === 0) return result;

  const links = await deps.links.find({
    where: { characterId: In(characterIds) },
  });
  if (links.length === 0) return result;

  const campaignIds = [...new Set(links.map((l) => l.campaignId))];
  const [campaigns, memberships] = await Promise.all([
    deps.campaigns.find({
      where: { id: In(campaignIds) },
      select: {
        id: true,
        name: true,
        allowPlayerSkipPayment: true,
      },
    }),
    deps.members.find({
      where: { userId, campaignId: In(campaignIds) },
      select: {
        campaignId: true,
        role: true,
      },
    }),
  ]);
  const campaignById = new Map(campaigns.map((c) => [c.id, c]));
  const roleByCampaignId = new Map(
    memberships.map((m) => [m.campaignId, m.role] as const),
  );

  for (const link of links) {
    const campaign = campaignById.get(link.campaignId);
    if (!campaign) continue;
    const list = result.get(link.characterId) ?? [];
    list.push({
      id: campaign.id,
      name: campaign.name,
      allowPlayerSkipPayment: campaign.allowPlayerSkipPayment,
      myRole: roleByCampaignId.get(campaign.id) ?? null,
    });
    result.set(link.characterId, list);
  }

  return result;
}
