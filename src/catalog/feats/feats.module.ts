import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { FeatsController } from './feats.controller';
import { FeatsService } from './feats.service';

@Module({
  imports: [TypeOrmModule.forFeature([VPhbFeat])],
  controllers: [FeatsController],
  providers: [FeatsService],
})
export class FeatsModule {}
