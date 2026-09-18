import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbCreatureTemplate } from '@entities/template/phb-creature-template.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterDiceModule } from '../dice/character-dice.module';
import { CharacterSessionModule } from '../session/character-session.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { EffectsModule } from '../effects/effects.module';
import { ActorModule } from '../actor/actor.module';
import { GameActor } from '../actor/infrastructure/game-actor.entity';
import { GameActorAction } from '../actor/infrastructure/game-actor-action.entity';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { Skirmish } from './infrastructure/skirmish.entity';
import { SkirmishCombatant } from './infrastructure/skirmish-combatant.entity';
import { SkirmishRepository } from './infrastructure/skirmish.repository';
import { SkirmishService } from './application/skirmish.service';
import { SkirmishesController } from './skirmishes.controller';

@Module({
  imports: [
    GameSharedModule,
    CombatModule,
    CharacterDiceModule,
    CharacterSessionModule,
    CharacterSheetModule,
    ActorModule,
    EffectsModule,
    TypeOrmModule.forFeature([
      Skirmish,
      SkirmishCombatant,
      GameActor,
      GameActorAction,
      PlayerCharacterItem,
      PhbCreatureTemplate,
    ]),
  ],
  controllers: [SkirmishesController],
  providers: [SkirmishRepository, SkirmishService],
})
export class SkirmishModule {}
