import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogLookupModule } from '@catalog/catalog-lookup.module';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import { PhbSpellSpiritVariant } from '@entities/spirit/phb-spell-spirit.entity';
import { SpellsController } from './spells.controller';
import { SpellsMapper } from './spells.mapper';
import { FindSpellsQuery } from './queries/find-spells.query';
import { FindSpellBySlugQuery } from './queries/find-spell-by-slug.query';
import { FindSpellSpiritVariantsQuery } from './queries/find-spell-spirit-variants.query';

@Module({
  imports: [
    CatalogLookupModule,
    TypeOrmModule.forFeature([VPhbSpell, PhbSpellSpiritVariant]),
  ],
  controllers: [SpellsController],
  providers: [
    SpellsMapper,
    FindSpellsQuery,
    FindSpellBySlugQuery,
    FindSpellSpiritVariantsQuery,
  ],
})
export class SpellsModule {}
