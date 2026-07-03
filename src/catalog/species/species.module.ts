import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { SpeciesController } from './species.controller';
import { SpeciesService } from './species.service';

@Module({
  imports: [TypeOrmModule.forFeature([PhbSpecies])],
  controllers: [SpeciesController],
  providers: [SpeciesService],
})
export class SpeciesModule {}
