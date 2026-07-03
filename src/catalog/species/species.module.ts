import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
import { CatalogLookupModule } from '../catalog-lookup.module';
import { SpeciesController } from './species.controller';
import { SpeciesMapper } from './species.mapper';
import { FindSpeciesQuery } from './queries/find-species.query';
import { FindSpeciesBySlugQuery } from './queries/find-species-by-slug.query';
import { FindSpeciesTraitsQuery } from './queries/find-species-traits.query';
import { FindSpeciesTraitChoicesQuery } from './queries/find-species-trait-choices.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([PhbSpecies, PhbSpeciesTrait, VPhbSpeciesTraitChoices]),
    CatalogLookupModule,
  ],
  controllers: [SpeciesController],
  providers: [
    SpeciesMapper,
    FindSpeciesQuery,
    FindSpeciesBySlugQuery,
    FindSpeciesTraitsQuery,
    FindSpeciesTraitChoicesQuery,
  ],
})
export class SpeciesModule {}
