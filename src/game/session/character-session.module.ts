import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { PhbCondition } from './infrastructure/phb-condition.entity';
import { PlayerCharacterState } from './infrastructure/player-character-state.entity';
import { CharacterStateRepository } from './infrastructure/character-state.repository';
import { CharacterSessionController } from './character-session.controller';
import { GetCharacterStateQuery } from './application/get-character-state.query';
import { PatchCharacterStateHandler } from './application/patch-character-state.handler';
import { CastSpellHandler } from './application/cast-spell.handler';
import { RestHandler } from './application/rest.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterState,
      PhbCondition,
      VClassSpellSlots,
    ]),
    GameSharedModule,
    CharacterSheetModule,
    CatalogModule,
  ],
  controllers: [CharacterSessionController],
  providers: [
    CharacterStateRepository,
    GetCharacterStateQuery,
    PatchCharacterStateHandler,
    CastSpellHandler,
    RestHandler,
  ],
})
export class CharacterSessionModule {}
