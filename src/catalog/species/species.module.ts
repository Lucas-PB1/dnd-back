import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
import { SpeciesController } from './species.controller';
import { SpeciesService } from './species.service';

@Module({
  imports: [TypeOrmModule.forFeature([PhbSpecies, PhbSpeciesTrait, VPhbSpeciesTraitChoices])],
  controllers: [SpeciesController],
  providers: [SpeciesService],
})
export class SpeciesModule {}
