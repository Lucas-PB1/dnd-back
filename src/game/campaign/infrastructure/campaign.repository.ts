import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { Campaign } from './campaign.entity';
import { CampaignMember, CampaignRole } from './campaign-member.entity';
import { CampaignCharacter } from './campaign-character.entity';
import {
  findCharactersByIds,
  linkCharacter,
  listCampaignRefsByCharacterIds,
  listLinkedCharacters,
  unlinkCharacter,
} from './campaign/campaign-character-links';
import {
  createCampaign,
  deleteCampaign,
  findCampaignOrFail,
  listForUser,
  rotateInviteCode,
  updateCampaign,
} from './campaign/campaign-crud';
import {
  joinByInviteCode,
  listMembers,
  removeMember,
  requireMember,
  requireRole,
  updateMemberRole,
} from './campaign/campaign-membership';

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

  private membershipDeps() {
    return { campaigns: this.campaigns, members: this.members };
  }

  private crudDeps() {
    return this.membershipDeps();
  }

  private linkDeps() {
    return {
      ...this.membershipDeps(),
      links: this.links,
      characterRows: this.characterRows,
      characters: this.characters,
    };
  }

  async createCampaign(input: {
    userId: string;
    name: string;
    description?: string | null;
  }): Promise<{ campaign: Campaign; membership: CampaignMember }> {
    return createCampaign(this.crudDeps(), input);
  }

  async listForUser(
    userId: string,
  ): Promise<Array<{ campaign: Campaign; role: CampaignRole }>> {
    return listForUser(this.crudDeps(), userId);
  }

  async findCampaignOrFail(id: string): Promise<Campaign> {
    return findCampaignOrFail(this.crudDeps(), id);
  }

  async requireMember(
    campaignId: string,
    userId: string,
  ): Promise<CampaignMember> {
    return requireMember(this.membershipDeps(), campaignId, userId);
  }

  async requireRole(
    campaignId: string,
    userId: string,
    roles: readonly CampaignRole[],
  ): Promise<CampaignMember> {
    return requireRole(this.membershipDeps(), campaignId, userId, roles);
  }

  async updateCampaign(
    campaignId: string,
    userId: string,
    patch: { name?: string; description?: string | null },
  ): Promise<Campaign> {
    return updateCampaign(this.crudDeps(), campaignId, userId, patch);
  }

  async deleteCampaign(campaignId: string, userId: string): Promise<void> {
    return deleteCampaign(this.crudDeps(), campaignId, userId);
  }

  async joinByInviteCode(
    userId: string,
    inviteCode: string,
    role: CampaignRole = 'player',
  ): Promise<{ campaign: Campaign; membership: CampaignMember }> {
    return joinByInviteCode(this.membershipDeps(), userId, inviteCode, role);
  }

  async listMembers(campaignId: string): Promise<CampaignMember[]> {
    return listMembers(this.membershipDeps(), campaignId);
  }

  async updateMemberRole(
    campaignId: string,
    actorUserId: string,
    targetUserId: string,
    role: CampaignRole,
  ): Promise<CampaignMember> {
    return updateMemberRole(
      this.membershipDeps(),
      campaignId,
      actorUserId,
      targetUserId,
      role,
    );
  }

  async removeMember(
    campaignId: string,
    actorUserId: string,
    targetUserId: string,
  ): Promise<void> {
    return removeMember(
      this.membershipDeps(),
      campaignId,
      actorUserId,
      targetUserId,
    );
  }

  async linkCharacter(
    campaignId: string,
    userId: string,
    characterId: string,
  ): Promise<CampaignCharacter> {
    return linkCharacter(this.linkDeps(), campaignId, userId, characterId);
  }

  async unlinkCharacter(
    campaignId: string,
    userId: string,
    characterId: string,
  ): Promise<void> {
    return unlinkCharacter(this.linkDeps(), campaignId, userId, characterId);
  }

  async listLinkedCharacters(
    campaignId: string,
  ): Promise<CampaignCharacter[]> {
    return listLinkedCharacters(this.linkDeps(), campaignId);
  }

  async findCharactersByIds(ids: string[]): Promise<PlayerCharacter[]> {
    return findCharactersByIds(this.linkDeps(), ids);
  }

  async rotateInviteCode(
    campaignId: string,
    userId: string,
  ): Promise<Campaign> {
    return rotateInviteCode(this.crudDeps(), campaignId, userId);
  }

  async listCampaignRefsByCharacterIds(
    characterIds: string[],
  ): Promise<Map<string, Array<{ id: string; name: string }>>> {
    return listCampaignRefsByCharacterIds(
      { links: this.links, campaigns: this.campaigns },
      characterIds,
    );
  }
}
