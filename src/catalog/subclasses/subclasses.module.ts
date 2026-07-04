import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbSubclassMechanics } from '../../entities/views/v-phb-subclass-mechanics.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import {
  PhbSubclassOptionValue,
  PhbSubclassRef,
} from '../../entities/phb-subclass-option-value.entity';
import { CatalogLookupModule } from '../catalog-lookup.module';
import { SubclassesController } from './subclasses.controller';
import { SubclassesMapper } from './subclasses.mapper';
import { FindSubclassBySlugQuery } from './queries/find-subclass-by-slug.query';
import { FindSubclassMechanicsQuery } from './queries/find-subclass-mechanics.query';
import { FindSubclassOptionsQuery } from './queries/find-subclass-options.query';
import { FindSubclassSpellsQuery } from './queries/find-subclass-spells.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbSubclassMechanics,
      VPhbSubclassPreparedSpell,
      PhbSubclassRef,
      PhbSubclassOptionValue,
    ]),
    CatalogLookupModule,
  ],
  controllers: [SubclassesController],
  providers: [
    SubclassesMapper,
    FindSubclassBySlugQuery,
    FindSubclassMechanicsQuery,
    FindSubclassOptionsQuery,
    FindSubclassSpellsQuery,
  ],
})
export class SubclassesModule {}
