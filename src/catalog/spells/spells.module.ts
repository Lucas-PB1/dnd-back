import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogLookupModule } from '@catalog/catalog-lookup.module';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import { SpellsController } from './spells.controller';
import { SpellsMapper } from './spells.mapper';
import { FindSpellsQuery } from './queries/find-spells.query';
import { FindSpellBySlugQuery } from './queries/find-spell-by-slug.query';

@Module({
  imports: [CatalogLookupModule, TypeOrmModule.forFeature([VPhbSpell])],
  controllers: [SpellsController],
  providers: [SpellsMapper, FindSpellsQuery, FindSpellBySlugQuery],
})
export class SpellsModule {}
