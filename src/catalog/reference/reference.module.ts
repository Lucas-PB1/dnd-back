import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbAlignment } from '../../entities/phb-alignment.entity';
import { PhbLanguage } from '../../entities/phb-language.entity';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { ReferenceMapper } from './reference.mapper';
import { FindAlignmentsQuery } from './queries/find-alignments.query';
import { FindLanguagesQuery } from './queries/find-languages.query';
import { FindCharacterLevelsQuery } from './queries/find-character-levels.query';
import { AlignmentsController } from './alignments.controller';
import { LanguagesController } from './languages.controller';
import { CharacterLevelsController } from './character-levels.controller';

@Module({
  imports: [TypeOrmModule.forFeature([PhbAlignment, PhbLanguage, PhbCharacterLevel])],
  controllers: [AlignmentsController, LanguagesController, CharacterLevelsController],
  providers: [
    ReferenceMapper,
    FindAlignmentsQuery,
    FindLanguagesQuery,
    FindCharacterLevelsQuery,
  ],
})
export class ReferenceModule {}
