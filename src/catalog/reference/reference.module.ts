import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbAlignment } from '../../entities/phb-alignment.entity';
import { PhbLanguage } from '../../entities/phb-language.entity';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { PhbAbilityGenerationMethod } from '../../entities/phb-ability-generation-method.entity';
import { PhbEdition } from '../../entities/phb-edition.entity';
import { PhbCondition } from '../../game/session/infrastructure/phb-condition.entity';
import { ReferenceMapper } from './reference.mapper';
import { FindAlignmentsQuery } from './queries/find-alignments.query';
import { FindLanguagesQuery } from './queries/find-languages.query';
import { FindLanguageBySlugQuery } from './queries/find-language-by-slug.query';
import { FindCharacterLevelsQuery } from './queries/find-character-levels.query';
import { FindAbilityGenerationMethodsQuery } from './queries/find-ability-generation-methods.query';
import { FindConditionsQuery } from './queries/find-conditions.query';
import { FindEditionsQuery } from './queries/find-editions.query';
import { AlignmentsController } from './alignments.controller';
import { LanguagesController } from './languages.controller';
import { CharacterLevelsController } from './character-levels.controller';
import { AbilityGenerationMethodsController } from './ability-generation-methods.controller';
import { ConditionsController } from './conditions.controller';
import { EditionsController } from './editions.controller';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbAlignment,
      PhbLanguage,
      PhbCharacterLevel,
      PhbAbilityGenerationMethod,
      PhbCondition,
      PhbEdition,
    ]),
  ],
  controllers: [
    AlignmentsController,
    LanguagesController,
    CharacterLevelsController,
    AbilityGenerationMethodsController,
    ConditionsController,
    EditionsController,
  ],
  providers: [
    ReferenceMapper,
    FindAlignmentsQuery,
    FindLanguagesQuery,
    FindLanguageBySlugQuery,
    FindCharacterLevelsQuery,
    FindAbilityGenerationMethodsQuery,
    FindConditionsQuery,
    FindEditionsQuery,
  ],
})
export class ReferenceModule {}
