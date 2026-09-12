import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import {
  PhbCompanionProfile,
  PhbCompanionTemplateMap,
} from '@entities/companion/phb-companion-profile.entity';
import { PhbCompanionCommand } from '@entities/companion/phb-companion-command.entity';
import {
  PhbSpellSpirit,
  PhbSpellSpiritVariant,
} from '@entities/spirit/phb-spell-spirit.entity';
import { PhbCreatureTemplate } from '@entities/template/phb-creature-template.entity';
import {
  PhbCreatureScaleByLevel,
  PhbCreatureScaleBySlot,
} from '@entities/template/phb-creature-scale.entity';
import { PhbVehicleTemplate } from '@entities/template/phb-vehicle-template.entity';
import { CatalogModule } from '@catalog/catalog.module';
import { SyncSpellSpiritHandler } from '@game/spirit/application/sync-spell-spirit.handler';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { PlayerCharacterState } from '../session/infrastructure/player-character-state.entity';
import { PhbCondition } from '../session/infrastructure/phb-condition.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import {
  BoardCharacterVehicleHandler,
  LinkCharacterVehicleHandler,
} from './application/character-vehicle.handlers';
import { SyncCharacterCompanionHandler } from './application/sync-character-companion.handler';
import { TemplateImageResolver } from './application/template-image.resolver';
import { CreateActorHandler } from './application/create-actor.handler';
import { DeleteActorHandler } from './application/delete-actor.handler';
import { GetActorQuery } from './application/get-actor.query';
import { GetActorStateQuery } from './application/get-actor-state.query';
import { ListActorsQuery } from './application/list-actors.query';
import { ListCharacterActorsQuery } from './application/list-character-actors.query';
import { PatchActorStateHandler } from './application/patch-actor-state.handler';
import { RollActorAttackHandler } from './application/roll-actor-attack.handler';
import { SpawnActorFromTemplateHandler } from './application/spawn-actor-from-template.handler';
import { UpdateActorHandler } from './application/update-actor.handler';
import { ActorsController } from './controllers/actors.controller';
import { ActorSessionController } from './controllers/actor-session.controller';
import { CharacterActorsController } from './controllers/character-actors.controller';
import { CharacterVehiclesController } from './controllers/character-vehicles.controller';
import { CharacterCompanionsController } from './controllers/character-companions.controller';
import { GameActorAccessService } from './game-actor-access.service';
import { ActorMapper } from './infrastructure/actor.mapper';
import { ActorPersistenceService } from './infrastructure/actor-persistence.service';
import { ActorRepository } from './infrastructure/actor.repository';
import { ActorSheetLoader } from './infrastructure/actor-sheet.loader';
import { ActorStateRepository } from './infrastructure/actor-state.repository';
import { GameActor } from './infrastructure/game-actor.entity';
import { GameActorAction } from './infrastructure/game-actor-action.entity';
import { GameActorSpeed } from './infrastructure/game-actor-speed.entity';
import { GameActorSpell } from './infrastructure/game-actor-spell.entity';
import { GameActorState } from './infrastructure/game-actor-state.entity';

@Module({
  imports: [
    GameSharedModule,
    CatalogModule,
    TypeOrmModule.forFeature([
      GameActor,
      GameActorSpeed,
      GameActorAction,
      GameActorSpell,
      GameActorState,
      PhbCondition,
      PlayerCharacterItem,
      PlayerCharacterState,
      PhbCreatureTemplate,
      PhbCreatureScaleByLevel,
      PhbCreatureScaleBySlot,
      PhbVehicleTemplate,
      PhbCompanionProfile,
      PhbCompanionTemplateMap,
      PhbCompanionCommand,
      PhbSpellSpirit,
      PhbSpellSpiritVariant,
      PhbSubclassRef,
    ]),
  ],
  controllers: [
    ActorsController,
    ActorSessionController,
    CharacterActorsController,
    CharacterVehiclesController,
    CharacterCompanionsController,
  ],
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
    LinkCharacterVehicleHandler,
    BoardCharacterVehicleHandler,
    SyncCharacterCompanionHandler,
    SyncSpellSpiritHandler,
    TemplateImageResolver,
  ],
  exports: [
    ActorRepository,
    GameActorAccessService,
    ActorPersistenceService,
    SyncCharacterCompanionHandler,
    SyncSpellSpiritHandler,
    TypeOrmModule,
  ],
})
export class ActorModule {}