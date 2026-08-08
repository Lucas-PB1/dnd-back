import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { PhbOptionDef, PhbOptionValue } from '../../entities/phb-option.entity';
import { PhbFeatRef } from '../../entities/phb-feat-ref.entity';
import { FeatsController } from './feats.controller';
import { FeatsMapper } from './feats.mapper';
import { FindFeatsQuery } from './queries/find-feats.query';
import { FindFeatBySlugQuery } from './queries/find-feat-by-slug.query';
import { FindFeatOptionsQuery } from './queries/find-feat-options.query';
import { FindFeatsBySlugsQuery } from './queries/find-feats-by-slugs.query';
import { FindFeatOptionsBySlugsQuery } from './queries/find-feat-options-by-slugs.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbFeat,
      PhbFeatRef,
      PhbOptionDef,
      PhbOptionValue,
    ]),
  ],
  controllers: [FeatsController],
  providers: [
    FeatsMapper,
    FindFeatsQuery,
    FindFeatBySlugQuery,
    FindFeatOptionsQuery,
    FindFeatsBySlugsQuery,
    FindFeatOptionsBySlugsQuery,
  ],
})
export class FeatsModule {}
