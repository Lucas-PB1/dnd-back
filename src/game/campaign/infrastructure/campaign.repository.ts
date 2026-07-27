import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { Campaign } from './campaign.entity';
import { CampaignMember, CampaignRole } from './campaign-member.entity';
import { CampaignCharacter } from './campaign-character.entity';
import { generateCampaignInviteCode } from '../domain/invite-code';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';

@Injectable()
export class CampaignRepository {
  constructor(
    @InjectRepository(Campaign)
    private readonly campaigns: Repository<Campaign>,
    @InjectRepository(CampaignMember)
    private readonly members: Repository<CampaignMember>,
    @InjectRepository(CampaignCharacter)
    private readonly links: Repository<CampaignCharacter>,
    @InjectRepository(PlayerCharacter)
    private readonly characterRows: Repository<PlayerCharacter>,
    private readonly characters: CharacterRepository,
  ) {}

  async createCampaign(input: {
    userId: string;
    name: string;
    description?: string | null;
  }): Promise<{ campaign: Campaign; membership: CampaignMember }> {
    let inviteCode = generateCampaignInviteCode();
    for (let attempt = 0; attempt < 5; attempt += 1) {
      const exists = await this.campaigns.exist({ where: { inviteCode } });
      if (!exists) break;
      inviteCode = generateCampaignInviteCode();
    }

    const campaign = await this.campaigns.save(
      this.campaigns.create({
        name: input.name.trim(),
        description: input.description?.trim() || null,
        inviteCode,
        createdBy: input.userId,
      }),
    );

    const membership = await this.members.save(
      this.members.create({
        campaignId: campaign.id,
        userId: input.userId,
        role: 'dm',
      }),
    );

    return { campaign, membership };
  }

  async listForUser(userId: string): Promise<
    Array<{ campaign: Campaign; role: CampaignRole }>
  > {
    const memberships = await this.members.find({ where: { userId } });
    if (memberships.length === 0) return [];

    const campaigns = await this.campaigns.find({
      where: { id: In(memberships.map((m) => m.campaignId)) },
      order: { updatedAt: 'DESC' },
    });

    const roleByCampaign = new Map(
      memberships.map((m) => [m.campaignId, m.role] as const),
    );

    return campaigns.map((campaign) => ({
      campaign,
      role: roleByCampaign.get(campaign.id)!,
    }));
  }

  async findCampaignOrFail(id: string): Promise<Campaign> {
    const row = await this.campaigns.findOne({ where: { id } });
    if (!row) throw new NotFoundException(`Campaign '${id}' not found`);
    return row;
  }

  async requireMember(
    campaignId: string,
    userId: string,
  ): Promise<CampaignMember> {
    const member = await this.members.findOne({
      where: { campaignId, userId },
    });
    if (!member) {
      throw new ForbiddenException('You are not a member of this campaign');
    }
    return member;
  }

  async requireRole(
    campaignId: string,
    userId: string,
    roles: readonly CampaignRole[],
  ): Promise<CampaignMember> {
    const member = await this.requireMember(campaignId, userId);
    if (!roles.includes(member.role)) {
      throw new ForbiddenException(
        `Requires campaign role: ${roles.join(' or ')}`,
      );
    }
    return member;
  }

  async updateCampaign(
    campaignId: string,
    userId: string,
    patch: { name?: string; description?: string | null },
  ): Promise<Campaign> {
    await this.requireRole(campaignId, userId, ['dm']);
    const campaign = await this.findCampaignOrFail(campaignId);
    if (patch.name !== undefined) campaign.name = patch.name.trim();
    if (patch.description !== undefined) {
      campaign.description = patch.description?.trim() || null;
    }
    return this.campaigns.save(campaign);
  }

  async deleteCampaign(campaignId: string, userId: string): Promise<void> {
    await this.requireRole(campaignId, userId, ['dm']);
    const campaign = await this.findCampaignOrFail(campaignId);
    await this.campaigns.remove(campaign);
  }

  async joinByInviteCode(
    userId: string,
    inviteCode: string,
    role: CampaignRole = 'player',
  ): Promise<{ campaign: Campaign; membership: CampaignMember }> {
    if (role === 'dm') {
      throw new BadRequestException('Cannot join as dm via invite code');
    }

    const code = inviteCode.trim().toUpperCase();
    const campaign = await this.campaigns.findOne({
      where: { inviteCode: code },
    });
    if (!campaign) {
      throw new NotFoundException('Invalid invite code');
    }

    const existing = await this.members.findOne({
      where: { campaignId: campaign.id, userId },
    });
    if (existing) {
      return { campaign, membership: existing };
    }

    const membership = await this.members.save(
      this.members.create({
        campaignId: campaign.id,
        userId,
        role,
      }),
    );

    return { campaign, membership };
  }

  async listMembers(campaignId: string): Promise<CampaignMember[]> {
    return this.members.find({
      where: { campaignId },
      order: { joinedAt: 'ASC' },
    });
  }

  async updateMemberRole(
    campaignId: string,
    actorUserId: string,
    targetUserId: string,
    role: CampaignRole,
  ): Promise<CampaignMember> {
    await this.requireRole(campaignId, actorUserId, ['dm']);
    const member = await this.members.findOne({
      where: { campaignId, userId: targetUserId },
    });
    if (!member) {
      throw new NotFoundException('Member not found in this campaign');
    }
    if (member.role === 'dm' && role !== 'dm') {
      const dmCount = await this.members.count({
        where: { campaignId, role: 'dm' },
      });
      if (dmCount <= 1) {
        throw new BadRequestException('Campaign must keep at least one dm');
      }
    }
    member.role = role;
    return this.members.save(member);
  }

  async removeMember(
    campaignId: string,
    actorUserId: string,
    targetUserId: string,
  ): Promise<void> {
    const actor = await this.requireMember(campaignId, actorUserId);
    if (actorUserId !== targetUserId && actor.role !== 'dm') {
      throw new ForbiddenException('Only dm can remove other members');
    }
    const member = await this.members.findOne({
      where: { campaignId, userId: targetUserId },
    });
    if (!member) {
      throw new NotFoundException('Member not found in this campaign');
    }
    if (member.role === 'dm') {
      const dmCount = await this.members.count({
        where: { campaignId, role: 'dm' },
      });
      if (dmCount <= 1) {
        throw new BadRequestException('Cannot remove the last dm');
      }
    }
    await this.members.remove(member);
  }

  async linkCharacter(
    campaignId: string,
    userId: string,
    characterId: string,
  ): Promise<CampaignCharacter> {
    await this.requireMember(campaignId, userId);
    const character = await this.characters.findOwnedOrFail(
      userId,
      characterId,
    );

    const existing = await this.links.findOne({
      where: { campaignId, characterId: character.id },
    });
    if (existing) return existing;

    return this.links.save(
      this.links.create({
        campaignId,
        characterId: character.id,
        linkedBy: userId,
      }),
    );
  }

  async unlinkCharacter(
    campaignId: string,
    userId: string,
    characterId: string,
  ): Promise<void> {
    const member = await this.requireMember(campaignId, userId);
    const link = await this.links.findOne({
      where: { campaignId, characterId },
    });
    if (!link) {
      throw new NotFoundException('Character is not linked to this campaign');
    }

    const owned = await this.characterRows.findOne({
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

    await this.links.remove(link);
  }

  async listLinkedCharacters(
    campaignId: string,
  ): Promise<CampaignCharacter[]> {
    return this.links.find({
      where: { campaignId },
      order: { linkedAt: 'ASC' },
    });
  }

  async findCharactersByIds(ids: string[]): Promise<PlayerCharacter[]> {
    if (ids.length === 0) return [];
    return this.characterRows.find({ where: { id: In(ids) } });
  }

  async rotateInviteCode(
    campaignId: string,
    userId: string,
  ): Promise<Campaign> {
    await this.requireRole(campaignId, userId, ['dm']);
    const campaign = await this.findCampaignOrFail(campaignId);
    let inviteCode = generateCampaignInviteCode();
    for (let attempt = 0; attempt < 5; attempt += 1) {
      const exists = await this.campaigns.exist({ where: { inviteCode } });
      if (!exists) break;
      inviteCode = generateCampaignInviteCode();
    }
    campaign.inviteCode = inviteCode;
    return this.campaigns.save(campaign);
  }

  /**
   * Mapa characterId → campanhas em que o personagem está vinculado.
   */
  async listCampaignRefsByCharacterIds(
    characterIds: string[],
  ): Promise<Map<string, Array<{ id: string; name: string }>>> {
    const result = new Map<string, Array<{ id: string; name: string }>>();
    if (characterIds.length === 0) return result;

    const links = await this.links.find({
      where: { characterId: In(characterIds) },
    });
    if (links.length === 0) return result;

    const campaigns = await this.campaigns.find({
      where: { id: In([...new Set(links.map((l) => l.campaignId))]) },
    });
    const campaignById = new Map(campaigns.map((c) => [c.id, c]));

    for (const link of links) {
      const campaign = campaignById.get(link.campaignId);
      if (!campaign) continue;
      const list = result.get(link.characterId) ?? [];
      list.push({ id: campaign.id, name: campaign.name });
      result.set(link.characterId, list);
    }

    return result;
  }
}
