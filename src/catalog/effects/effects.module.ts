import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbEffect } from '@entities/effect/phb-effect.entity';
import { PhbFeatRef } from '@entities/feat/phb-feat-ref.entity';
import { PhbSpecies } from '@entities/species/phb-species.entity';
import { FindOwnerEffectsQuery } from './queries/find-owner-effects.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbEffect, PhbFeatRef, PhbSpecies])],
  providers: [FindOwnerEffectsQuery],
  exports: [FindOwnerEffectsQuery],
})
export class CatalogEffectsModule {}
