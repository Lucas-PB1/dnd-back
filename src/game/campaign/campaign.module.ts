import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterDiceModule } from '../dice/character-dice.module';
import { CombatModule } from '../combat/combat.module';
import { ActorModule } from '../actor/actor.module';
import { GameActor } from '../actor/infrastructure/game-actor.entity';
import { GameActorState } from '../actor/infrastructure/game-actor-state.entity';
import { PlayerCharacterState } from '../session/infrastructure/player-character-state.entity';
import { Campaign } from './infrastructure/campaign.entity';
import { CampaignMember } from './infrastructure/campaign-member.entity';
import { CampaignCharacter } from './infrastructure/campaign-character.entity';
import { CampaignEncounter } from './infrastructure/campaign-encounter.entity';
import { CampaignEncounterCombatant } from './infrastructure/campaign-encounter-combatant.entity';
import { CampaignRepository } from './infrastructure/campaign.repository';
import { CampaignEncounterRepository } from './infrastructure/campaign-encounter.repository';
import { CampaignService } from './application/campaign.service';
import { CampaignEncounterService } from './application/campaign-encounter.service';
import { CampaignEncounterInitiativeService } from './application/campaign-encounter-initiative.service';
import { EnrichEncounterPcs } from './application/enrich-encounter-pcs';
import { EnrichEncounterActors } from './application/enrich-encounter-actors';
import { LoadEncounterDto } from './application/load-encounter-dto';
import { CampaignsController } from './campaigns.controller';
import { CampaignEncountersController } from './campaign-encounters.controller';

@Module({
  imports: [
    GameSharedModule,
    CombatModule,
    forwardRef(() => CharacterDiceModule),
    forwardRef(() => ActorModule),
    TypeOrmModule.forFeature([
      Campaign,
      CampaignMember,
      CampaignCharacter,
      CampaignEncounter,
      CampaignEncounterCombatant,
      PlayerCharacterState,
      GameActor,
      GameActorState,
    ]),
  ],
  controllers: [CampaignsController, CampaignEncountersController],
  providers: [
    CampaignRepository,
    CampaignService,
    CampaignEncounterRepository,
    CampaignEncounterService,
    CampaignEncounterInitiativeService,
    EnrichEncounterPcs,
    EnrichEncounterActors,
    LoadEncounterDto,
  ],
  exports: [CampaignRepository, CampaignService],
})
export class CampaignModule {}
