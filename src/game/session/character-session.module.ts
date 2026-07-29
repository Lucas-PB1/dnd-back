import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../entities/views/v-subclass-spell-slots.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { SpellcastingModule } from '../spellcasting/spellcasting.module';
import { PhbCondition } from './infrastructure/phb-condition.entity';
import { PlayerCharacterState } from './infrastructure/player-character-state.entity';
import { CharacterStateRepository } from './infrastructure/character-state.repository';
import { CharacterSessionController } from './character-session.controller';
import { GetCharacterStateQuery } from './application/get-character-state.query';
import { PatchCharacterStateHandler } from './application/patch-character-state.handler';
import { CastSpellHandler } from './application/cast-spell.handler';
import { RestHandler } from './application/rest.handler';
import { UseClassResourceHandler } from './application/use-class-resource.handler';
import { GunslingerActionsHandler } from './application/gunslinger-actions.handler';
import { BarbarianActionsHandler } from './application/barbarian-actions.handler';
import { FighterActionsHandler } from './application/fighter-actions.handler';
import { RogueActionsHandler } from './application/rogue-actions.handler';
import { MonkActionsHandler } from './application/monk-actions.handler';
import { PaladinActionsHandler } from './application/paladin-actions.handler';
import { RangerActionsHandler } from './application/ranger-actions.handler';
import { ClericActionsHandler } from './application/cleric-actions.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterState,
      PhbCondition,
      VClassSpellSlots,
      VSubclassSpellSlots,
    ]),
    GameSharedModule,
    forwardRef(() => CharacterSheetModule),
    SpellcastingModule,
    CatalogModule,
  ],
  controllers: [CharacterSessionController],
  providers: [
    CharacterStateRepository,
    GetCharacterStateQuery,
    PatchCharacterStateHandler,
    CastSpellHandler,
    RestHandler,
    UseClassResourceHandler,
    GunslingerActionsHandler,
    BarbarianActionsHandler,
    FighterActionsHandler,
    RogueActionsHandler,
    MonkActionsHandler,
    PaladinActionsHandler,
    RangerActionsHandler,
    ClericActionsHandler,
  ],
  exports: [CharacterStateRepository],
})
export class CharacterSessionModule {}
