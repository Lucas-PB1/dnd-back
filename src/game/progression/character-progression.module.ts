import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterSessionModule } from '../session/character-session.module';
import { LevelUpService } from './domain/level-up.service';
import { LevelUpPreviewQuery } from './application/level-up-preview.query';
import { LevelUpHandler } from './application/level-up.handler';
import { CharacterProgressionController } from './character-progression.controller';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbCharacterLevel,
      VSpellByClass,
      VPhbSubclassPreparedSpell,
      VClassSpellSlots,
    ]),
    GameSharedModule,
    CatalogModule,
    CharacterSheetModule,
    CharacterSessionModule,
  ],
  controllers: [CharacterProgressionController],
  providers: [LevelUpService, LevelUpPreviewQuery, LevelUpHandler],
})
export class CharacterProgressionModule {}
