import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbItem } from '../../entities/phb-item.entity';
import { ItemsController } from './items.controller';
import { ItemsMapper } from './items.mapper';
import { FindItemBySlugQuery } from './queries/find-item-by-slug.query';
import { FindItemsQuery } from './queries/find-items.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbItem])],
  controllers: [ItemsController],
  providers: [ItemsMapper, FindItemsQuery, FindItemBySlugQuery],
})
export class ItemsModule {}
