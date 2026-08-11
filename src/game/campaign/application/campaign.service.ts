import { Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { CampaignRepository } from '../infrastructure/campaign.repository';
import {
  CampaignDetailDto,
  CampaignMemberDto,
  CampaignSummaryDto,
  CreateCampaignDto,
  JoinCampaignDto,
  LinkCampaignCharacterDto,
  UpdateCampaignDto,
  UpdateCampaignMemberDto,
} from '../dto/campaign.dto';
import { Campaign } from '../infrastructure/campaign.entity';
import { CampaignMember, CampaignRole } from '../infrastructure/campaign-member.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { resolveAuthUserProfiles } from './resolve-auth-user-profiles';

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
    const profiles = await resolveAuthUserProfiles(
      this.dataSource,
      members.map((m) => m.userId),
    );

    return {
      ...this.toSummary(campaign, membership.role),
      members: members.map((m) =>
        this.toMemberDto(m, profiles, characters),
      ),
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
    return this.toMemberDto(member, profiles, characters);
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

  async rotateInvite(
    userId: string,
    campaignId: string,
  ): Promise<CampaignSummaryDto> {
    const campaign = await this.repo.rotateInviteCode(campaignId, userId);
    const membership = await this.repo.requireMember(campaignId, userId);
    return this.toSummary(campaign, membership.role);
  }

  listCampaignRefsByCharacterIds(characterIds: string[], userId: string) {
    return this.repo.listCampaignRefsByCharacterIds(characterIds, userId);
  }

  private toMemberDto(
    member: CampaignMember,
    profiles: Awaited<ReturnType<typeof resolveAuthUserProfiles>>,
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
      allowPlayerSkipPayment: campaign.allowPlayerSkipPayment,
      createdAt: campaign.createdAt.toISOString(),
      updatedAt: campaign.updatedAt.toISOString(),
    };
  }
}
