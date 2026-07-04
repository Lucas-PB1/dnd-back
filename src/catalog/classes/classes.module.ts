import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { VPhbClassSkillChoice } from '../../entities/views/v-phb-class-skill-choice.entity';
import { VPhbClassFeature } from '../../entities/views/v-phb-class-feature.entity';
import { CatalogLookupModule } from '../catalog-lookup.module';
import { ClassesController } from './classes.controller';
import { ClassesMapper } from './classes.mapper';
import { FindClassesQuery } from './queries/find-classes.query';
import { FindClassBySlugQuery } from './queries/find-class-by-slug.query';
import { FindClassSubclassesQuery } from './queries/find-class-subclasses.query';
import { FindClassSpellsQuery } from './queries/find-class-spells.query';
import { FindClassSpellSlotsQuery } from './queries/find-class-spell-slots.query';
import { FindClassEquipmentQuery } from './queries/find-class-equipment.query';
import { FindClassSkillsQuery } from './queries/find-class-skills.query';
import { FindClassFeaturesQuery } from './queries/find-class-features.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbClass,
      VPhbSubclass,
      VSpellByClass,
      VClassSpellSlots,
      VPhbClassEquipment,
      VPhbClassSkillChoice,
      VPhbClassFeature,
    ]),
    CatalogLookupModule,
  ],
  controllers: [ClassesController],
  providers: [
    ClassesMapper,
    FindClassesQuery,
    FindClassBySlugQuery,
    FindClassSubclassesQuery,
    FindClassSpellsQuery,
    FindClassSpellSlotsQuery,
    FindClassEquipmentQuery,
    FindClassSkillsQuery,
    FindClassFeaturesQuery,
  ],
})
export class ClassesModule {}
