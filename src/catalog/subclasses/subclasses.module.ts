import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbSubclass } from '@entities/views/v-phb-subclass.entity';
import { VPhbSubclassMechanics } from '@entities/views/v-phb-subclass-mechanics.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { PhbOptionValue } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { CatalogLookupModule } from '../catalog-lookup.module';
import { SubclassesController } from './subclasses.controller';
import { SubclassesMapper } from './subclasses.mapper';
import { FindSubclassesQuery } from './queries/find-subclasses.query';
import { FindSubclassBySlugQuery } from './queries/find-subclass-by-slug.query';
import { FindSubclassMechanicsQuery } from './queries/find-subclass-mechanics.query';
import { FindSubclassOptionsQuery } from './queries/find-subclass-options.query';
import { FindSubclassSpellsQuery } from './queries/find-subclass-spells.query';
import { FindSubclassSpellSlotsQuery } from './queries/find-subclass-spell-slots.query';
import { FindSubclassSpellcastingQuery } from './queries/find-subclass-spellcasting.query';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbSubclass,
      VPhbSubclassMechanics,
      VPhbSubclassPreparedSpell,
      VSubclassSpellSlots,
      PhbSubclassRef,
      PhbOptionValue,
    ]),
    CatalogLookupModule,
  ],
  controllers: [SubclassesController],
  providers: [
    SubclassesMapper,
    FindSubclassesQuery,
    FindSubclassBySlugQuery,
    FindSubclassMechanicsQuery,
    FindSubclassOptionsQuery,
    FindSubclassSpellsQuery,
    FindSubclassSpellSlotsQuery,
    FindSubclassSpellcastingQuery,
  ],
})
export class SubclassesModule {}
