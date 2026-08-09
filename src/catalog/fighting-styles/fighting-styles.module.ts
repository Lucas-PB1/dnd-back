import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbFightingStyle } from '@entities/phb-fighting-style.entity';
import { FightingStylesController } from './fighting-styles.controller';
import { FightingStylesMapper } from './fighting-styles.mapper';
import { FindFightingStylesQuery } from './queries/find-fighting-styles.query';
import { FindFightingStyleBySlugQuery } from './queries/find-fighting-style-by-slug.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbFightingStyle])],
  controllers: [FightingStylesController],
  providers: [
    FightingStylesMapper,
    FindFightingStylesQuery,
    FindFightingStyleBySlugQuery,
  ],
})
export class FightingStylesModule {}
