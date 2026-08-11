import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogLookupModule } from '@catalog/catalog-lookup.module';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbItemCatalogStats } from '@entities/phb-item-catalog-stats.entity';
import { RecordItemCatalogStatsService } from './application/record-item-catalog-stats.service';
import { FindPopularItemsQuery } from './queries/find-popular-items.query';
import { ItemsController } from './items.controller';
import { ItemsMapper } from './items.mapper';
import { FindItemBySlugQuery } from './queries/find-item-by-slug.query';
import { FindItemsQuery } from './queries/find-items.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([PhbItem, PhbItemCatalogStats]),
    CatalogLookupModule,
  ],
  controllers: [ItemsController],
  providers: [
    ItemsMapper,
    FindItemsQuery,
    FindItemBySlugQuery,
    FindPopularItemsQuery,
    RecordItemCatalogStatsService,
  ],
  exports: [RecordItemCatalogStatsService],
})
export class ItemsModule {}
