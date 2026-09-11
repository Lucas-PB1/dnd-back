import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbCreatureTemplate } from '@entities/template/phb-creature-template.entity';
import { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CampaignRepository } from '../../infrastructure/campaign.repository';
import { CampaignEncounterRepository } from '../../infrastructure/campaign-encounter.repository';
import { LoadEncounterDto } from '../load-encounter-dto';
import { requireActiveEncounter } from '../require-active-encounter';
import { clearCursemarkedLockForCurrentPc } from '../clear-cursemarked-lock-on-turn';
import {
  AddEncounterCreatureDto,
  CampaignEncounterDto,
  CreateCampaignEncounterDto,
  PatchCampaignEncounterDto,
  PatchEncounterCombatantDto,
} from '../../dto/encounter.dto';
import {
  addEncounterCreature,
  patchEncounterCombatant,
  removeEncounterCombatant,
} from './combatant-ops';
import {
  closeEncounter,
  createEncounter,
  getActiveEncounter,
  getEncounter,
  patchEncounter,
} from './lifecycle';

@Injectable()
export class CampaignEncounterService {
  constructor(
    private readonly campaigns: CampaignRepository,
    private readonly encounters: CampaignEncounterRepository,
    private readonly loadDto: LoadEncounterDto,
    private readonly actorPersistence: ActorPersistenceService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(PhbCreatureTemplate)
    private readonly creatureTemplates: Repository<PhbCreatureTemplate>,
    private readonly characterState: CharacterStateRepository,
  ) {}

  private lifecycleDeps() {
    return {
      campaigns: this.campaigns,
      encounters: this.encounters,
      loadDto: this.loadDto,
    };
  }

  private combatantDeps() {
    return {
      ...this.lifecycleDeps(),
      actorPersistence: this.actorPersistence,
      actors: this.actors,
      creatureTemplates: this.creatureTemplates,
    };
  }

  create(
    userId: string,
    campaignId: string,
    dto: CreateCampaignEncounterDto,
  ): Promise<CampaignEncounterDto> {
    return createEncounter(this.lifecycleDeps(), userId, campaignId, dto);
  }

  getActive(userId: string, campaignId: string) {
    return getActiveEncounter(this.lifecycleDeps(), userId, campaignId);
  }

  getOne(userId: string, campaignId: string, encounterId: string) {
    return getEncounter(this.lifecycleDeps(), userId, campaignId, encounterId);
  }

  patchEncounter(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: PatchCampaignEncounterDto,
  ): Promise<CampaignEncounterDto> {
    return patchEncounter(
      this.lifecycleDeps(),
      userId,
      campaignId,
      encounterId,
      dto,
    );
  }

  addCreature(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: AddEncounterCreatureDto,
  ): Promise<CampaignEncounterDto> {
    return addEncounterCreature(
      this.combatantDeps(),
      userId,
      campaignId,
      encounterId,
      dto,
    );
  }

  patchCombatant(
    userId: string,
    campaignId: string,
    encounterId: string,
    combatantId: string,
    dto: PatchEncounterCombatantDto,
  ): Promise<CampaignEncounterDto> {
    return patchEncounterCombatant(
      this.combatantDeps(),
      userId,
      campaignId,
      encounterId,
      combatantId,
      dto,
    );
  }

  removeCombatant(
    userId: string,
    campaignId: string,
    encounterId: string,
    combatantId: string,
  ): Promise<CampaignEncounterDto> {
    return removeEncounterCombatant(
      this.combatantDeps(),
      userId,
      campaignId,
      encounterId,
      combatantId,
    );
  }

  async nextTurn(userId: string, campaignId: string, encounterId: string) {
    await this.campaigns.requireRole(campaignId, userId, ['dm', 'assistant']);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    await this.encounters.refreshSortOrders(encounter.id);
    const advanced = await this.encounters.advanceTurn(encounter);
    await clearCursemarkedLockForCurrentPc({
      encounters: this.encounters,
      characterState: this.characterState,
      encounter: advanced,
    });
    return this.loadDto.load(advanced, 'dm');
  }

  close(userId: string, campaignId: string, encounterId: string) {
    return closeEncounter(this.lifecycleDeps(), userId, campaignId, encounterId);
  }
}
