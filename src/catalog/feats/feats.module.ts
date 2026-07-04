import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../entities/phb-feat-option.entity';
import { FeatsController } from './feats.controller';
import { FeatsMapper } from './feats.mapper';
import { FindFeatsQuery } from './queries/find-feats.query';
import { FindFeatBySlugQuery } from './queries/find-feat-by-slug.query';
import { FindFeatOptionsQuery } from './queries/find-feat-options.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbFeat,
      PhbFeatRef,
      PhbFeatOptionDef,
      PhbFeatOptionValue,
    ]),
  ],
  controllers: [FeatsController],
  providers: [FeatsMapper, FindFeatsQuery, FindFeatBySlugQuery, FindFeatOptionsQuery],
})
export class FeatsModule {}
