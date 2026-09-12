import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { Campaign } from '@game/campaign/infrastructure/campaign.entity';
import { CampaignCharacter } from '@game/campaign/infrastructure/campaign-character.entity';
import {
  CampaignMember,
  CampaignRole,
} from '@game/campaign/infrastructure/campaign-member.entity';
import {
  listCampaignRefsByCharacterIds as listRefs,
  type CampaignRefsByCharacterId,
} from './campaign.repository/campaign-character-links';

export type CharacterAccessMode = 'read' | 'write' | 'own';

const WRITE_ROLES: readonly CampaignRole[] = ['dm', 'assistant'];

@Injectable()
export class CampaignCharacterAccessService {
  constructor(
    @InjectRepository(CampaignCharacter)
    private readonly links: Repository<CampaignCharacter>,
    @InjectRepository(CampaignMember)
    private readonly members: Repository<CampaignMember>,
    @InjectRepository(Campaign)
    private readonly campaigns: Repository<Campaign>,
  ) {}

  async hasAccess(
    userId: string,
    characterId: string,
    mode: CharacterAccessMode,
  ): Promise<boolean> {
    if (mode === 'own') return false;

    const characterLinks = await this.links.find({ where: { characterId } });
    if (characterLinks.length === 0) return false;

    const campaignIds = characterLinks.map((link) => link.campaignId);
    const memberships = await this.members.find({
      where: { userId, campaignId: In(campaignIds) },
    });

    if (memberships.length === 0) return false;
    if (mode === 'read') return true;

    return memberships.some((m) => WRITE_ROLES.includes(m.role));
  }

  async findMemberRole(
    campaignId: string,
    userId: string,
  ): Promise<CampaignRole | null> {
    const row = await this.members.findOne({
      where: { campaignId, userId },
    });
    return row?.role ?? null;
  }


  listCampaignRefsByCharacterIds(
    characterIds: string[],
    userId: string,
  ): Promise<CampaignRefsByCharacterId> {
    return listRefs(
      {
        links: this.links,
        campaigns: this.campaigns,
        members: this.members,
      },
      characterIds,
      userId,
    );
  }


  async resolveInventoryPaymentContext(
    userId: string,
    characterId: string,
  ): Promise<{
    inCampaign: boolean;
    viewerIsDmOrAssistant: boolean;
    allowPlayerSkipPayment: boolean;
  }> {
    const characterLinks = await this.links.find({ where: { characterId } });
    if (characterLinks.length === 0) {
      return {
        inCampaign: false,
        viewerIsDmOrAssistant: false,
        allowPlayerSkipPayment: false,
      };
    }

    const campaignIds = characterLinks.map((link) => link.campaignId);
    const [memberships, campaigns] = await Promise.all([
      this.members.find({
        where: { userId, campaignId: In(campaignIds) },
      }),
      this.campaigns.find({ where: { id: In(campaignIds) } }),
    ]);

    return {
      inCampaign: true,
      viewerIsDmOrAssistant: memberships.some((m) =>
        WRITE_ROLES.includes(m.role),
      ),
      allowPlayerSkipPayment: campaigns.some((c) => c.allowPlayerSkipPayment),
    };
  }
}
