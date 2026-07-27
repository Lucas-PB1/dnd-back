import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { CampaignCharacter } from '../../campaign/infrastructure/campaign-character.entity';
import {
  CampaignMember,
  CampaignRole,
} from '../../campaign/infrastructure/campaign-member.entity';

export type CharacterAccessMode = 'read' | 'write' | 'own';

const WRITE_ROLES: readonly CampaignRole[] = ['dm', 'assistant'];

/** Acesso a personagem via vínculo em campanha (além do dono). */
@Injectable()
export class CampaignCharacterAccessService {
  constructor(
    @InjectRepository(CampaignCharacter)
    private readonly links: Repository<CampaignCharacter>,
    @InjectRepository(CampaignMember)
    private readonly members: Repository<CampaignMember>,
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
}
