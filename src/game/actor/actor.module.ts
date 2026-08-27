import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GameSharedModule } from '../shared/game-shared.module';
import { CampaignModule } from '../campaign/campaign.module';
import { CatalogModule } from '@catalog/catalog.module';
import { GameActor } from './infrastructure/game-actor.entity';
import { GameActorSpeed } from './infrastructure/game-actor-speed.entity';
import { GameActorAction } from './infrastructure/game-actor-action.entity';
import { GameActorSpell } from './infrastructure/game-actor-spell.entity';
import { GameActorState } from './infrastructure/game-actor-state.entity';
import { PhbCondition } from '../session/infrastructure/phb-condition.entity';
import { ActorRepository } from './infrastructure/actor.repository';
import { GameActorAccessService } from './game-actor-access.service';
import { ActorSheetLoader } from './infrastructure/actor-sheet.loader';
import { ActorMapper } from './infrastructure/actor.mapper';
import { ActorPersistenceService } from './infrastructure/actor-persistence.service';
import { ActorStateRepository } from './infrastructure/actor-state.repository';
import { CharacterActorsController } from './controllers/character-actors.controller';
import { ActorsController } from './controllers/actors.controller';
import { ListCharacterActorsQuery } from './application/list-character-actors.query';
import { ActorSessionController } from './controllers/actor-session.controller';
import { ListActorsQuery } from './application/list-actors.query';
import { GetActorQuery } from './application/get-actor.query';
import { CreateActorHandler } from './application/create-actor.handler';
import { UpdateActorHandler } from './application/update-actor.handler';
import { DeleteActorHandler } from './application/delete-actor.handler';
import { SpawnActorFromTemplateHandler } from './application/spawn-actor-from-template.handler';
import { GetActorStateQuery } from './application/get-actor-state.query';
import { PatchActorStateHandler } from './application/patch-actor-state.handler';
import { RollActorAttackHandler } from './application/roll-actor-attack.handler';

@Module({
  imports: [
    GameSharedModule,
    forwardRef(() => CampaignModule),
    CatalogModule,
    TypeOrmModule.forFeature([
      GameActor,
      GameActorSpeed,
      GameActorAction,
      GameActorSpell,
      GameActorState,
      PhbCondition,
    ]),
  ],
  controllers: [ActorsController, ActorSessionController, CharacterActorsController],
  providers: [
    ActorRepository,
    GameActorAccessService,
    ActorSheetLoader,
    ActorMapper,
    ActorPersistenceService,
    ActorStateRepository,
    ListActorsQuery,
    ListCharacterActorsQuery,
    GetActorQuery,
    CreateActorHandler,
    UpdateActorHandler,
    DeleteActorHandler,
    SpawnActorFromTemplateHandler,
    GetActorStateQuery,
    PatchActorStateHandler,
    RollActorAttackHandler,
  ],
  exports: [
    ActorRepository,
    GameActorAccessService,
    ActorPersistenceService,
    TypeOrmModule,
  ],
})
export class ActorModule {}
