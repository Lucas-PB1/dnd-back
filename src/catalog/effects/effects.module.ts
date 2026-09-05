import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbEffect } from '@entities/phb-effect.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { PhbSpecies } from '@entities/phb-species.entity';
import { FindOwnerEffectsQuery } from './queries/find-owner-effects.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbEffect, PhbFeatRef, PhbSpecies])],
  providers: [FindOwnerEffectsQuery],
  exports: [FindOwnerEffectsQuery],
})
export class CatalogEffectsModule {}
