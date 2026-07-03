import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../characters/character-sheet.module';
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
    ]),
    GameSharedModule,
    CatalogModule,
    CharacterSheetModule,
  ],
  controllers: [CharacterProgressionController],
  providers: [LevelUpService, LevelUpPreviewQuery, LevelUpHandler],
})
export class CharacterProgressionModule {}
