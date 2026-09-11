import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '@catalog/catalog.module';
import { CombatModule } from '../combat/combat.module';
import { ActorModule } from '../actor/actor.module';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterInventoryModule } from '../inventory/character-inventory.module';
import { SpellcastingModule } from '../spellcasting/spellcasting.module';
import { EffectsModule } from '../effects/effects.module';
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
import { GunslingerActionsHandler } from './application/actions/gunslinger/gunslinger-actions.handler';
import { BarbarianActionsHandler } from './application/actions/barbarian/barbarian-actions.handler';
import { FighterActionsHandler } from './application/actions/fighter/fighter-actions.handler';
import { RogueActionsHandler } from './application/actions/rogue/rogue-actions.handler';
import { MonkActionsHandler } from './application/actions/monk/monk-actions.handler';
import { PaladinActionsHandler } from './application/actions/paladin/paladin-actions.handler';
import { RangerActionsHandler } from './application/actions/ranger/ranger-actions.handler';
import { ClericActionsHandler } from './application/actions/cleric/cleric-actions.handler';
import { BardActionsHandler } from './application/actions/bard/bard-actions.handler';
import { SorcererActionsHandler } from './application/actions/sorcerer/sorcerer-actions.handler';
import { WarlockActionsHandler } from './application/actions/warlock/warlock-actions.handler';
import { DruidActionsHandler } from './application/actions/druid/druid-actions.handler';
import { WizardActionsHandler } from './application/actions/wizard/wizard-actions.handler';
import { MonsterHunterActionsHandler } from './application/actions/monster-hunter/monster-hunter-actions.handler';
import { TransformationActionsHandler } from './application/actions/transformation/transformation-actions.handler';
import { FeatEconomyActionsHandler } from './application/actions/feat/feat-economy-actions.handler';
import { TransferInspirationHandler } from './application/core/transfer-inspiration.handler';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { CampaignCharacter } from '../campaign/infrastructure/campaign-character.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterState,
      PhbCondition,
      VClassSpellSlots,
      VSubclassSpellSlots,
      PlayerCharacterItem,
      CampaignCharacter,
    ]),
    GameSharedModule,
    CharacterSheetModule,
    CharacterInventoryModule,
    SpellcastingModule,
    EffectsModule,
    CatalogModule,
    CombatModule,
    ActorModule,
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
    MonsterHunterActionsHandler,
    TransformationActionsHandler,
    FeatEconomyActionsHandler,
    TransferInspirationHandler,
  ],
  exports: [CharacterStateRepository],
})
export class CharacterSessionModule {}
