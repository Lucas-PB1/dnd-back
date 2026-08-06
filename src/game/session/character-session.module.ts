import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { CombatModule } from '../combat/combat.module';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../entities/views/v-subclass-spell-slots.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { SpellcastingModule } from '../spellcasting/spellcasting.module';
import { PhbCondition } from './infrastructure/phb-condition.entity';
import { PlayerCharacterState } from './infrastructure/player-character-state.entity';
import { CharacterStateRepository } from './infrastructure/character-state.repository';
import { CharacterSessionController } from './controllers/character-session.controller';
import { GunslingerBarbarianSessionController } from './controllers/gunslinger-barbarian-session.controller';
import { FighterSessionController } from './controllers/fighter-session.controller';
import { TableActionsController } from './controllers/table-actions.controller';
import { GetCharacterStateQuery } from './application/core/get-character-state.query';
import { PatchCharacterStateHandler } from './application/core/patch-character-state.handler';
import { CastSpellHandler } from './application/core/cast-spell.handler';
import { RestHandler } from './application/core/rest.handler';
import { UseClassResourceHandler } from './application/core/use-class-resource.handler';
import { RecoverClassResourceHandler } from './application/core/recover-class-resource.handler';
import { GunslingerActionsHandler } from './application/actions/gunslinger-actions.handler';
import { BarbarianActionsHandler } from './application/actions/barbarian-actions.handler';
import { FighterActionsHandler } from './application/actions/fighter-actions.handler';
import { RogueActionsHandler } from './application/actions/rogue-actions.handler';
import { MonkActionsHandler } from './application/actions/monk-actions.handler';
import { PaladinActionsHandler } from './application/actions/paladin-actions.handler';
import { RangerActionsHandler } from './application/actions/ranger-actions.handler';
import { ClericActionsHandler } from './application/actions/cleric-actions.handler';
import { BardActionsHandler } from './application/actions/bard-actions.handler';
import { SorcererActionsHandler } from './application/actions/sorcerer-actions.handler';
import { WarlockActionsHandler } from './application/actions/warlock-actions.handler';
import { DruidActionsHandler } from './application/actions/druid-actions.handler';
import { WizardActionsHandler } from './application/actions/wizard-actions.handler';

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
    CombatModule,
  ],
  controllers: [
    CharacterSessionController,
    GunslingerBarbarianSessionController,
    FighterSessionController,
    TableActionsController,
  ],
  providers: [
    CharacterStateRepository,
    GetCharacterStateQuery,
    PatchCharacterStateHandler,
    CastSpellHandler,
    RestHandler,
    UseClassResourceHandler,
    RecoverClassResourceHandler,
    GunslingerActionsHandler,
    BarbarianActionsHandler,
    FighterActionsHandler,
    RogueActionsHandler,
    MonkActionsHandler,
    PaladinActionsHandler,
    RangerActionsHandler,
    ClericActionsHandler,
    BardActionsHandler,
    SorcererActionsHandler,
    WarlockActionsHandler,
    DruidActionsHandler,
    WizardActionsHandler,
  ],
  exports: [CharacterStateRepository],
})
export class CharacterSessionModule {}
