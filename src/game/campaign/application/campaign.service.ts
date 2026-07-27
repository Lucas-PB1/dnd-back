import { Injectable } from '@nestjs/common';
import { CampaignRepository } from '../infrastructure/campaign.repository';
import {
  CampaignDetailDto,
  CampaignSummaryDto,
  CreateCampaignDto,
  JoinCampaignDto,
  LinkCampaignCharacterDto,
  UpdateCampaignDto,
  UpdateCampaignMemberDto,
} from '../dto/campaign.dto';
import { Campaign } from '../infrastructure/campaign.entity';
import { CampaignRole } from '../infrastructure/campaign-member.entity';

@Injectable()
export class CampaignService {
  constructor(private readonly repo: CampaignRepository) {}

  async create(
    userId: string,
    dto: CreateCampaignDto,
  ): Promise<CampaignSummaryDto> {
    const { campaign, membership } = await this.repo.createCampaign({
      userId,
      name: dto.name,
      description: dto.description,
    });
    return this.toSummary(campaign, membership.role);
  }

  async list(userId: string): Promise<CampaignSummaryDto[]> {
    const rows = await this.repo.listForUser(userId);
    return rows.map(({ campaign, role }) => this.toSummary(campaign, role));
  }

  async getDetail(
    userId: string,
    campaignId: string,
  ): Promise<CampaignDetailDto> {
    const membership = await this.repo.requireMember(campaignId, userId);
    const campaign = await this.repo.findCampaignOrFail(campaignId);
    const members = await this.repo.listMembers(campaignId);
    const links = await this.repo.listLinkedCharacters(campaignId);
    const characters = await this.repo.findCharactersByIds(
      links.map((l) => l.characterId),
    );
    const byId = new Map(characters.map((c) => [c.id, c]));

    return {
      ...this.toSummary(campaign, membership.role),
      members: members.map((m) => ({
        userId: m.userId,
        role: m.role,
        joinedAt: m.joinedAt.toISOString(),
      })),
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

  async update(
    userId: string,
    campaignId: string,
    dto: UpdateCampaignDto,
  ): Promise<CampaignSummaryDto> {
    const campaign = await this.repo.updateCampaign(campaignId, userId, dto);
    const membership = await this.repo.requireMember(campaignId, userId);
    return this.toSummary(campaign, membership.role);
  }

  async remove(userId: string, campaignId: string): Promise<void> {
    await this.repo.deleteCampaign(campaignId, userId);
  }

  async join(
    userId: string,
    dto: JoinCampaignDto,
  ): Promise<CampaignSummaryDto> {
    const { campaign, membership } = await this.repo.joinByInviteCode(
      userId,
      dto.inviteCode,
      dto.role ?? 'player',
    );
    return this.toSummary(campaign, membership.role);
  }

  async updateMemberRole(
    userId: string,
    campaignId: string,
    targetUserId: string,
    dto: UpdateCampaignMemberDto,
  ) {
    const member = await this.repo.updateMemberRole(
      campaignId,
      userId,
      targetUserId,
      dto.role,
    );
    return {
      userId: member.userId,
      role: member.role,
      joinedAt: member.joinedAt.toISOString(),
    };
  }

  async removeMember(
    userId: string,
    campaignId: string,
    targetUserId: string,
  ): Promise<void> {
    await this.repo.removeMember(campaignId, userId, targetUserId);
  }

  async linkCharacter(
    userId: string,
    campaignId: string,
    dto: LinkCampaignCharacterDto,
  ) {
    const link = await this.repo.linkCharacter(
      campaignId,
      userId,
      dto.characterId,
    );
    const [character] = await this.repo.findCharactersByIds([
      link.characterId,
    ]);
    return {
      characterId: link.characterId,
      name: character?.name ?? '',
      level: character?.level ?? 0,
      classSlug: character?.classSlug ?? '',
      speciesSlug: character?.speciesSlug ?? '',
      linkedAt: link.linkedAt.toISOString(),
    };
  }

  async unlinkCharacter(
    userId: string,
    campaignId: string,
    characterId: string,
  ): Promise<void> {
    await this.repo.unlinkCharacter(campaignId, userId, characterId);
  }

  private toSummary(
    campaign: Campaign,
    role: CampaignRole,
  ): CampaignSummaryDto {
    return {
      id: campaign.id,
      name: campaign.name,
      description: campaign.description,
      inviteCode: campaign.inviteCode,
      myRole: role,
      createdAt: campaign.createdAt.toISOString(),
      updatedAt: campaign.updatedAt.toISOString(),
    };
  }
}
