import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/species/phb-species.entity';
import { PhbHeritage } from '../entities/heritage/phb-heritage.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/reference/phb-alignment.entity';
import { VPhbClassSkillChoice } from '../entities/views/v-phb-class-skill-choice.entity';
import { VPhbFeat } from '../entities/views/v-phb-feat.entity';
import { PhbLanguage } from '../entities/reference/phb-language.entity';
import { PhbAbilityGenerationMethod } from '../entities/reference/phb-ability-generation-method.entity';
import { PhbItem } from '../entities/equipment/phb-item.entity';
import { VPhbSpell } from '../entities/views/v-phb-spell.entity';
import { PhbSkill } from '../entities/reference/phb-skill.entity';
import { CatalogLookupService } from './catalog-lookup.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbClass,
      PhbSpecies,
      PhbHeritage,
      VPhbBackground,
      VPhbSubclass,
      PhbAlignment,
      VPhbClassSkillChoice,
      VPhbFeat,
      PhbLanguage,
      PhbAbilityGenerationMethod,
      PhbItem,
      VPhbSpell,
      PhbSkill,
    ]),
  ],
  providers: [CatalogLookupService],
  exports: [CatalogLookupService],
})
export class CatalogLookupModule {}
