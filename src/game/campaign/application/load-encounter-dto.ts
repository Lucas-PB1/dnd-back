import { Injectable } from '@nestjs/common';
import { CampaignRepository } from '../infrastructure/campaign.repository';
import { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import {
  buildCampaignEncounterDto,
  type EncounterViewer,
} from '../domain/build-encounter-dto';
import type { CampaignEncounterDto } from '../dto/encounter.dto';
import { EnrichEncounterPcs } from './enrich-encounter-pcs';

@Injectable()
export class LoadEncounterDto {
  constructor(
    private readonly campaigns: CampaignRepository,
    private readonly encounters: CampaignEncounterRepository,
    private readonly enrichPcs: EnrichEncounterPcs,
  ) {}

  async load(
    encounter: CampaignEncounter,
    viewer: EncounterViewer,
  ): Promise<CampaignEncounterDto> {
    const combatantRows = await this.encounters.listCombatants(encounter.id);
    const pcIds = combatantRows
      .map((row) => row.characterId)
      .filter((id): id is string => id != null);
    const characters = await this.campaigns.findCharactersByIds(pcIds);
    const enrichment = await this.enrichPcs.enrich(characters);
    return buildCampaignEncounterDto({
      encounter,
      combatants: combatantRows,
      pcNameById: new Map(characters.map((c) => [c.id, c.name])),
      pcEnrichmentByCharacterId: enrichment,
      viewer,
    });
  }
}
