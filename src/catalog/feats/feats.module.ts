import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbFeat } from '@entities/views/v-phb-feat.entity';
import { VPhbBackground } from '@entities/views/v-phb-background.entity';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { FeatsController } from './feats.controller';
import { FeatsMapper } from './feats.mapper';
import { FindFeatsQuery } from './queries/find-feats.query';
import { FindFeatBySlugQuery } from './queries/find-feat-by-slug.query';
import { FindFeatOptionsQuery } from './queries/find-feat-options.query';
import { FindFeatsBySlugsQuery } from './queries/find-feats-by-slugs.query';
import { FindFeatOptionsBySlugsQuery } from './queries/find-feat-options-by-slugs.query';
import { FindFeatOriginBackgroundsQuery } from './queries/find-feat-origin-backgrounds.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbFeat,
      VPhbBackground,
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
    FindFeatOriginBackgroundsQuery,
  ],
})
export class FeatsModule {}
