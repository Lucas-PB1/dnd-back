import { Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { CampaignRepository } from '../../infrastructure/campaign.repository';
import {
  CampaignMemberDto,
  CampaignSummaryDto,
  CreateCampaignDto,
  JoinCampaignDto,
  LinkCampaignCharacterDto,
  UpdateCampaignDto,
  UpdateCampaignMemberDto,
} from '../../dto/campaign.dto';
import { resolveAuthUserProfiles } from '../resolve-auth-user-profiles';
import { buildCampaignDetail } from './build-detail';
import { toLinkedCharacterDto, toMemberDto, toSummary } from './to-dto';

@Injectable()
export class CampaignService {
  constructor(
    private readonly repo: CampaignRepository,
    @InjectDataSource() private readonly dataSource: DataSource,
  ) {}

  async create(
    userId: string,
    dto: CreateCampaignDto,
  ): Promise<CampaignSummaryDto> {
    const { campaign, membership } = await this.repo.createCampaign({
      userId,
      name: dto.name,
      description: dto.description,
    });
    return toSummary(campaign, membership.role);
  }

  async list(userId: string): Promise<CampaignSummaryDto[]> {
    const rows = await this.repo.listForUser(userId);
    return rows.map(({ campaign, role }) => toSummary(campaign, role));
  }

  getDetail(userId: string, campaignId: string) {
    return buildCampaignDetail(this.repo, this.dataSource, userId, campaignId);
  }

  async update(
    userId: string,
    campaignId: string,
    dto: UpdateCampaignDto,
  ): Promise<CampaignSummaryDto> {
    const campaign = await this.repo.updateCampaign(campaignId, userId, dto);
    const membership = await this.repo.requireMember(campaignId, userId);
    return toSummary(campaign, membership.role);
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
    return toSummary(campaign, membership.role);
  }

  async updateMemberRole(
    userId: string,
    campaignId: string,
    targetUserId: string,
    dto: UpdateCampaignMemberDto,
  ): Promise<CampaignMemberDto> {
    const member = await this.repo.updateMemberRole(
      campaignId,
      userId,
      targetUserId,
      dto.role,
    );
    const profiles = await resolveAuthUserProfiles(this.dataSource, [
      member.userId,
    ]);
    const links = await this.repo.listLinkedCharacters(campaignId);
    const characters = await this.repo.findCharactersByIds(
      links.map((l) => l.characterId),
    );
    return toMemberDto(member, profiles, characters);
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
    return toLinkedCharacterDto(link, character);
  }

  async unlinkCharacter(
    userId: string,
    campaignId: string,
    characterId: string,
  ): Promise<void> {
    await this.repo.unlinkCharacter(campaignId, userId, characterId);
  }

  async rotateInvite(
    userId: string,
    campaignId: string,
  ): Promise<CampaignSummaryDto> {
    const campaign = await this.repo.rotateInviteCode(campaignId, userId);
    const membership = await this.repo.requireMember(campaignId, userId);
    return toSummary(campaign, membership.role);
  }

  listCampaignRefsByCharacterIds(characterIds: string[], userId: string) {
    return this.repo.listCampaignRefsByCharacterIds(characterIds, userId);
  }
}
