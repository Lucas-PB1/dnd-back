import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { FeatsController } from './feats.controller';
import { FeatsMapper } from './feats.mapper';
import { FindFeatsQuery } from './queries/find-feats.query';
import { FindFeatBySlugQuery } from './queries/find-feat-by-slug.query';

@Module({
  imports: [TypeOrmModule.forFeature([VPhbFeat])],
  controllers: [FeatsController],
  providers: [FeatsMapper, FindFeatsQuery, FindFeatBySlugQuery],
})
export class FeatsModule {}
