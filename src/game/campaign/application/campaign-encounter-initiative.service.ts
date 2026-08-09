import { Injectable } from '@nestjs/common';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { CampaignRepository } from '../infrastructure/campaign.repository';
import { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import { viewerFromMember } from './encounter-combatant-ops';
import {
  applyCombatantInitiativeRoll,
  assertCanRollInitiative,
} from './encounter-initiative-roll';
import { LoadEncounterDto } from './load-encounter-dto';
import {
  CampaignEncounterDto,
  RollEncounterInitiativeDto,
} from '../dto/encounter.dto';
import { requireActiveEncounter } from './require-active-encounter';

@Injectable()
export class CampaignEncounterInitiativeService {
  constructor(
    private readonly campaigns: CampaignRepository,
    private readonly encounters: CampaignEncounterRepository,
    private readonly rolls: CharacterRollsService,
    private readonly loadDto: LoadEncounterDto,
  ) {}

  async rollOne(
    userId: string,
    campaignId: string,
    encounterId: string,
    combatantId: string,
    dto: RollEncounterInitiativeDto,
  ): Promise<CampaignEncounterDto> {
    const member = await this.campaigns.requireMember(campaignId, userId);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    const combatant = await this.encounters.findCombatantByIdOrFail(
      encounter.id,
      combatantId,
    );
    await assertCanRollInitiative({
      campaigns: this.campaigns,
      userId,
      role: member.role,
      combatant,
    });
    await applyCombatantInitiativeRoll({
      rolls: this.rolls,
      encounters: this.encounters,
      userId,
      combatant,
      dto,
    });
    await this.encounters.refreshSortOrders(encounter.id);
    return this.loadDto.load(encounter, viewerFromMember(member));
  }

  async rollAll(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: RollEncounterInitiativeDto,
  ): Promise<CampaignEncounterDto> {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    const combatants = await this.encounters.listCombatants(encounter.id);
    for (const combatant of combatants) {
      if (!combatant.isActive || combatant.initiativeTotal != null) continue;
      await applyCombatantInitiativeRoll({
        rolls: this.rolls,
        encounters: this.encounters,
        userId,
        combatant,
        dto,
      });
    }
    await this.encounters.refreshSortOrders(encounter.id);
    encounter.currentTurnIndex = 0;
    await this.encounters.saveEncounter(encounter);
    return this.loadDto.load(encounter, 'dm');
  }
}
