import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbAlignment } from '../../entities/phb-alignment.entity';
import { PhbLanguage } from '../../entities/phb-language.entity';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { ReferenceService } from './reference.service';
import { AlignmentsController } from './alignments.controller';
import { LanguagesController } from './languages.controller';
import { CharacterLevelsController } from './character-levels.controller';

@Module({
  imports: [TypeOrmModule.forFeature([PhbAlignment, PhbLanguage, PhbCharacterLevel])],
  controllers: [AlignmentsController, LanguagesController, CharacterLevelsController],
  providers: [ReferenceService],
})
export class ReferenceModule {}
