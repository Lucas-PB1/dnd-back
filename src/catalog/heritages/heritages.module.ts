import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbHeritage } from '@entities/phb-heritage.entity';
import { PhbHeritageTrait } from '@entities/phb-heritage-trait.entity';
import { VPhbHeritageTraitChoices } from '@entities/views/v-phb-heritage-trait-choices.entity';
import { VPhbHeritageTraditionalBuild } from '@entities/views/v-phb-heritage-traditional-build.entity';
import { CatalogLookupModule } from '../catalog-lookup.module';
import { HeritagesController } from './heritages.controller';
import { HeritagesMapper } from './heritages.mapper';
import { FindHeritagesQuery } from './queries/find-heritages.query';
import { FindHeritageBySlugQuery } from './queries/find-heritage-by-slug.query';
import { FindHeritageTraitsQuery } from './queries/find-heritage-traits.query';
import { FindHeritageTraitChoicesQuery } from './queries/find-heritage-trait-choices.query';
import { FindHeritageTraditionalBuildQuery } from './queries/find-heritage-traditional-build.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbHeritage,
      PhbHeritageTrait,
      VPhbHeritageTraitChoices,
      VPhbHeritageTraditionalBuild,
    ]),
    CatalogLookupModule,
  ],
  controllers: [HeritagesController],
  providers: [
    HeritagesMapper,
    FindHeritagesQuery,
    FindHeritageBySlugQuery,
    FindHeritageTraitsQuery,
    FindHeritageTraitChoicesQuery,
    FindHeritageTraditionalBuildQuery,
  ],
})
export class HeritagesModule {}
