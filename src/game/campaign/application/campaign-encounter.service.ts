import { BadRequestException, Injectable } from '@nestjs/common';
import { CampaignRepository } from '../infrastructure/campaign.repository';
import { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import {
  assertPlayerCanViewEncounter,
  applyCombatantPatch,
  viewerFromMember,
} from './encounter-combatant-ops';
import { LoadEncounterDto } from './load-encounter-dto';
import { requireActiveEncounter } from './require-active-encounter';
import {
  AddEncounterCreatureDto,
  CampaignEncounterDto,
  CreateCampaignEncounterDto,
  PatchCampaignEncounterDto,
  PatchEncounterCombatantDto,
} from '../dto/encounter.dto';

@Injectable()
export class CampaignEncounterService {
  constructor(
    private readonly campaigns: CampaignRepository,
    private readonly encounters: CampaignEncounterRepository,
    private readonly loadDto: LoadEncounterDto,
  ) {}

  async create(
    userId: string,
    campaignId: string,
    dto: CreateCampaignEncounterDto,
  ): Promise<CampaignEncounterDto> {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const links = await this.campaigns.listLinkedCharacters(campaignId);
    const encounter = await this.encounters.createActive({
      campaignId,
      name: dto.name,
      createdBy: userId,
      characterIds: links.map((link) => link.characterId),
    });
    return this.loadDto.load(encounter, 'dm');
  }

  async getActive(userId: string, campaignId: string) {
    const member = await this.campaigns.requireMember(campaignId, userId);
    const encounter = await this.encounters.findActiveOrFail(campaignId);
    assertPlayerCanViewEncounter(member, encounter);
    return this.loadDto.load(encounter, viewerFromMember(member));
  }

  async getOne(userId: string, campaignId: string, encounterId: string) {
    const member = await this.campaigns.requireMember(campaignId, userId);
    const encounter = await this.encounters.findEncounterInCampaignOrFail(
      campaignId,
      encounterId,
    );
    assertPlayerCanViewEncounter(member, encounter);
    return this.loadDto.load(encounter, viewerFromMember(member));
  }

  async patchEncounter(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: PatchCampaignEncounterDto,
  ): Promise<CampaignEncounterDto> {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    if (dto.name !== undefined) encounter.name = dto.name.trim();
    if (dto.playersCanView !== undefined) {
      encounter.playersCanView = dto.playersCanView;
    }
    if (dto.creatureHpVisibility !== undefined) {
      encounter.creatureHpVisibility = dto.creatureHpVisibility;
    }
    await this.encounters.saveEncounter(encounter);
    return this.loadDto.load(encounter, 'dm');
  }

  async addCreature(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: AddEncounterCreatureDto,
  ): Promise<CampaignEncounterDto> {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    await this.encounters.addCreature({
      encounterId: encounter.id,
      name: dto.name,
      hpMax: dto.hpMax,
      hpCurrent: dto.hpCurrent ?? dto.hpMax,
      armorClass: dto.armorClass,
      initiativeModifier: dto.initiativeModifier ?? null,
    });
    await this.encounters.refreshSortOrders(encounter.id);
    return this.loadDto.load(encounter, 'dm');
  }

  async patchCombatant(
    userId: string,
    campaignId: string,
    encounterId: string,
    combatantId: string,
    dto: PatchEncounterCombatantDto,
  ): Promise<CampaignEncounterDto> {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    await requireActiveEncounter(this.encounters, campaignId, encounterId);
    const combatant = await this.encounters.findCombatantByIdOrFail(
      encounterId,
      combatantId,
    );
    applyCombatantPatch(combatant, dto);
    await this.encounters.saveCombatant(combatant);
    await this.encounters.refreshSortOrders(encounterId);
    return this.loadDto.load(
      await this.encounters.findEncounterInCampaignOrFail(
        campaignId,
        encounterId,
      ),
      'dm',
    );
  }

  async removeCombatant(
    userId: string,
    campaignId: string,
    encounterId: string,
    combatantId: string,
  ): Promise<CampaignEncounterDto> {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    const combatant = await this.encounters.findCombatantByIdOrFail(
      encounter.id,
      combatantId,
    );
    await this.encounters.deleteCombatant(combatant);
    await this.encounters.refreshSortOrders(encounter.id);
    return this.loadDto.load(encounter, 'dm');
  }

  async nextTurn(userId: string, campaignId: string, encounterId: string) {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    await this.encounters.refreshSortOrders(encounter.id);
    return this.loadDto.load(
      await this.encounters.advanceTurn(encounter),
      'dm',
    );
  }

  async close(userId: string, campaignId: string, encounterId: string) {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await this.encounters.findEncounterInCampaignOrFail(
      campaignId,
      encounterId,
    );
    if (encounter.status === 'closed') {
      throw new BadRequestException('Encounter is already closed');
    }
    encounter.status = 'closed';
    await this.encounters.saveEncounter(encounter);
    return this.loadDto.load(encounter, 'dm');
  }
}
