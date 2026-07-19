import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';
import { VPhbClassSkillChoice } from '../entities/views/v-phb-class-skill-choice.entity';
import { VPhbFeat } from '../entities/views/v-phb-feat.entity';
import { PhbLanguage } from '../entities/phb-language.entity';
import { PhbAbilityGenerationMethod } from '../entities/phb-ability-generation-method.entity';
import { PhbItem } from '../entities/phb-item.entity';
import { VPhbSpell } from '../entities/views/v-phb-spell.entity';
import { CatalogLookupService } from './catalog-lookup.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbClass,
      PhbSpecies,
      VPhbBackground,
      VPhbSubclass,
      PhbAlignment,
      VPhbClassSkillChoice,
      VPhbFeat,
      PhbLanguage,
      PhbAbilityGenerationMethod,
      PhbItem,
      VPhbSpell,
    ]),
  ],
  providers: [CatalogLookupService],
  exports: [CatalogLookupService],
})
export class CatalogLookupModule {}
