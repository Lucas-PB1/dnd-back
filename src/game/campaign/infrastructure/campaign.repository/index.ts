import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { Campaign } from '../campaign.entity';
import { CampaignMember, CampaignRole } from '../campaign-member.entity';
import { CampaignCharacter } from '../campaign-character.entity';
import {
  findCharactersByIds,
  linkCharacter,
  listCampaignRefsByCharacterIds,
  listLinkedCharacters,
  unlinkCharacter,
  type CampaignRefsByCharacterId,
} from './campaign-character-links';
import {
  createCampaign,
  deleteCampaign,
  findCampaignOrFail,
  listForUser,
  rotateInviteCode,
  updateCampaign,
} from './campaign-crud';
import {
  joinByInviteCode,
  listMembers,
  removeMember,
  requireMember,
  requireRole,
  updateMemberRole,
} from './campaign-membership';

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

  createCampaign(input: {
    userId: string;
    name: string;
    description?: string | null;
  }) {
    return createCampaign(this.crudDeps(), input);
  }

  listForUser(userId: string) {
    return listForUser(this.crudDeps(), userId);
  }

  findCampaignOrFail(id: string) {
    return findCampaignOrFail(this.crudDeps(), id);
  }

  requireMember(campaignId: string, userId: string) {
    return requireMember(this.membershipDeps(), campaignId, userId);
  }

  requireRole(
    campaignId: string,
    userId: string,
    roles: readonly CampaignRole[],
  ) {
    return requireRole(this.membershipDeps(), campaignId, userId, roles);
  }

  updateCampaign(
    campaignId: string,
    userId: string,
    patch: {
      name?: string;
      description?: string | null;
      allowPlayerSkipPayment?: boolean;
    },
  ) {
    return updateCampaign(this.crudDeps(), campaignId, userId, patch);
  }

  deleteCampaign(campaignId: string, userId: string) {
    return deleteCampaign(this.crudDeps(), campaignId, userId);
  }

  joinByInviteCode(
    userId: string,
    inviteCode: string,
    role: CampaignRole = 'player',
  ) {
    return joinByInviteCode(this.membershipDeps(), userId, inviteCode, role);
  }

  listMembers(campaignId: string) {
    return listMembers(this.membershipDeps(), campaignId);
  }

  updateMemberRole(
    campaignId: string,
    actorUserId: string,
    targetUserId: string,
    role: CampaignRole,
  ) {
    return updateMemberRole(
      this.membershipDeps(),
      campaignId,
      actorUserId,
      targetUserId,
      role,
    );
  }

  removeMember(
    campaignId: string,
    actorUserId: string,
    targetUserId: string,
  ) {
    return removeMember(
      this.membershipDeps(),
      campaignId,
      actorUserId,
      targetUserId,
    );
  }

  linkCharacter(campaignId: string, userId: string, characterId: string) {
    return linkCharacter(this.linkDeps(), campaignId, userId, characterId);
  }

  unlinkCharacter(campaignId: string, userId: string, characterId: string) {
    return unlinkCharacter(this.linkDeps(), campaignId, userId, characterId);
  }

  listLinkedCharacters(campaignId: string) {
    return listLinkedCharacters(this.linkDeps(), campaignId);
  }

  findCharactersByIds(ids: string[]) {
    return findCharactersByIds(this.linkDeps(), ids);
  }

  rotateInviteCode(campaignId: string, userId: string) {
    return rotateInviteCode(this.crudDeps(), campaignId, userId);
  }

  listCampaignRefsByCharacterIds(
    characterIds: string[],
    userId: string,
  ): Promise<CampaignRefsByCharacterId> {
    return listCampaignRefsByCharacterIds(
      { links: this.links, campaigns: this.campaigns, members: this.members },
      characterIds,
      userId,
    );
  }
}
