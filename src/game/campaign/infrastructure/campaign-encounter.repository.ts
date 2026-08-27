import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CampaignRepository } from './campaign.repository';
import { CampaignEncounter } from './campaign-encounter.entity';
import { CampaignEncounterCombatant } from './campaign-encounter-combatant.entity';
import {
  advanceEncounterTurn,
  sortCombatantsByInitiative,
} from '../domain/encounter-initiative';

@Injectable()
export class CampaignEncounterRepository {
  constructor(
    @InjectRepository(CampaignEncounter)
    private readonly encounters: Repository<CampaignEncounter>,
    @InjectRepository(CampaignEncounterCombatant)
    private readonly combatants: Repository<CampaignEncounterCombatant>,
    private readonly campaigns: CampaignRepository,
  ) {}

  async findActiveOrFail(campaignId: string): Promise<CampaignEncounter> {
    const row = await this.encounters.findOne({
      where: { campaignId, status: 'active' },
    });
    if (!row) throw new NotFoundException('No active encounter in this campaign');
    return row;
  }

  async findEncounterInCampaignOrFail(
    campaignId: string,
    encounterId: string,
  ): Promise<CampaignEncounter> {
    const row = await this.encounters.findOne({
      where: { id: encounterId, campaignId },
    });
    if (!row) throw new NotFoundException('Encounter not found in this campaign');
    return row;
  }

  async createActive(input: {
    campaignId: string;
    name: string;
    createdBy: string;
    characterIds: string[];
  }): Promise<CampaignEncounter> {
    const existing = await this.encounters.findOne({
      where: { campaignId: input.campaignId, status: 'active' },
    });
    if (existing) {
      throw new BadRequestException(
        'Campaign already has an active encounter; close it first',
      );
    }

    const encounter = await this.encounters.save(
      this.encounters.create({
        campaignId: input.campaignId,
        name: input.name.trim(),
        status: 'active',
        round: 1,
        currentTurnIndex: 0,
        playersCanView: false,
        creatureHpVisibility: 'percent',
        createdBy: input.createdBy,
      }),
    );

    if (input.characterIds.length > 0) {
      await this.combatants.save(
        input.characterIds.map((characterId, index) =>
          this.combatants.create({
            encounterId: encounter.id,
            kind: 'pc',
            characterId,
            actorId: null,
            initiativeTotal: null,
            initiativeModifier: null,
            sortOrder: index,
            isActive: true,
          }),
        ),
      );
    }

    return encounter;
  }

  async addActor(input: {
    encounterId: string;
    actorId: string;
    initiativeModifier: number | null;
  }): Promise<CampaignEncounterCombatant> {
    const count = await this.combatants.count({
      where: { encounterId: input.encounterId },
    });
    return this.combatants.save(
      this.combatants.create({
        encounterId: input.encounterId,
        kind: 'actor',
        characterId: null,
        actorId: input.actorId,
        initiativeTotal: null,
        initiativeModifier: input.initiativeModifier,
        sortOrder: count,
        isActive: true,
      }),
    );
  }

  async listCombatants(
    encounterId: string,
  ): Promise<CampaignEncounterCombatant[]> {
    return this.combatants.find({ where: { encounterId } });
  }

  async findCombatantByIdOrFail(
    encounterId: string,
    combatantId: string,
  ): Promise<CampaignEncounterCombatant> {
    const row = await this.combatants.findOne({
      where: { id: combatantId, encounterId },
    });
    if (!row) {
      throw new NotFoundException('Combatant not found in this encounter');
    }
    return row;
  }

  async saveCombatant(
    row: CampaignEncounterCombatant,
  ): Promise<CampaignEncounterCombatant> {
    return this.combatants.save(row);
  }

  async deleteCombatant(row: CampaignEncounterCombatant): Promise<void> {
    await this.combatants.remove(row);
  }

  async saveEncounter(row: CampaignEncounter): Promise<CampaignEncounter> {
    return this.encounters.save(row);
  }

  async refreshSortOrders(
    encounterId: string,
    actorNameById: Map<string, string> = new Map(),
  ): Promise<CampaignEncounterCombatant[]> {
    const rows = await this.listCombatants(encounterId);
    const pcIds = rows
      .map((row) => row.characterId)
      .filter((id): id is string => id != null);
    const characters = await this.campaigns.findCharactersByIds(pcIds);
    const nameById = new Map(characters.map((c) => [c.id, c.name]));

    const sorted = sortCombatantsByInitiative(
      rows.map((row) => ({
        combatantId: row.id,
        initiativeTotal: row.initiativeTotal,
        initiativeModifier: row.initiativeModifier,
        isActive: row.isActive,
        displayName:
          row.kind === 'actor' && row.actorId
            ? (actorNameById.get(row.actorId) ?? 'Actor')
            : (nameById.get(row.characterId ?? '') ??
              row.characterId ??
              row.id),
      })),
    );
    const byId = new Map(rows.map((row) => [row.id, row]));
    for (let i = 0; i < sorted.length; i += 1) {
      const row = byId.get(sorted[i].combatantId);
      if (row) row.sortOrder = i;
    }
    return this.combatants.save(rows);
  }

  async advanceTurn(encounter: CampaignEncounter): Promise<CampaignEncounter> {
    const rows = await this.listCombatants(encounter.id);
    const next = advanceEncounterTurn({
      currentTurnIndex: encounter.currentTurnIndex,
      round: encounter.round,
      activeCount: rows.filter((row) => row.isActive).length,
    });
    encounter.currentTurnIndex = next.currentTurnIndex;
    encounter.round = next.round;
    return this.encounters.save(encounter);
  }
}
