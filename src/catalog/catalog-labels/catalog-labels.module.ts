import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbArmorCategory } from '@entities/equipment/phb-armor-category.entity';
import { PhbSpellSchool } from '@entities/spell/phb-spell-school.entity';
import { VPhbFeatCategory } from '@entities/views/v-phb-feat-category.entity';
import { VPhbItemType } from '@entities/views/v-phb-item-type.entity';
import { VPhbToolPoolItem } from '@entities/views/v-phb-tool-pool-item.entity';
import { VPhbWeaponCategory } from '@entities/views/v-phb-weapon-category.entity';
import { CatalogLabelsController } from './catalog-labels.controller';
import { FindArmorCategoriesQuery } from './queries/find-armor-categories.query';
import { FindFeatCategoriesQuery } from './queries/find-feat-categories.query';
import { FindItemTypesQuery } from './queries/find-item-types.query';
import { FindSpellSchoolsQuery } from './queries/find-spell-schools.query';
import { FindToolPoolsQuery } from './queries/find-tool-pools.query';
import { FindWeaponCategoriesQuery } from './queries/find-weapon-categories.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbSpellSchool,
      PhbArmorCategory,
      VPhbFeatCategory,
      VPhbWeaponCategory,
      VPhbItemType,
      VPhbToolPoolItem,
    ]),
  ],
  controllers: [CatalogLabelsController],
  providers: [
    FindSpellSchoolsQuery,
    FindFeatCategoriesQuery,
    FindWeaponCategoriesQuery,
    FindArmorCategoriesQuery,
    FindItemTypesQuery,
    FindToolPoolsQuery,
  ],
})
export class CatalogLabelsModule {}
