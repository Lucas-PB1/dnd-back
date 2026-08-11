import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbItemCatalogStats } from '@entities/phb-item-catalog-stats.entity';
import { ItemsMapper } from '../items.mapper';
import { ItemSummaryResponseDto } from '../dto/item-summary-response.dto';

/** Mais comprados / vistos — telemetria (dicas Beyond shop). */
@Injectable()
export class FindPopularItemsQuery {
  constructor(
    @InjectRepository(PhbItemCatalogStats)
    private readonly stats: Repository<PhbItemCatalogStats>,
    private readonly mapper: ItemsMapper,
  ) {}

  async execute(
    metric: 'purchase' | 'view' = 'purchase',
    limit = 8,
  ): Promise<ItemSummaryResponseDto[]> {
    const orderCol = metric === 'view' ? 'view_count' : 'purchase_count';
    const capped = Math.min(Math.max(limit, 1), 40);
    const raw = await this.stats.query(
      `SELECT i.slug, i.name, i.item_type, i.cost, i.weight, i.properties
       FROM rpg.phb_item_catalog_stats s
       JOIN rpg.phb_item i ON i.slug = s.item_slug
       ORDER BY s.${orderCol} DESC, i.name ASC
       LIMIT $1`,
      [capped],
    );

    return (raw as Array<Record<string, unknown>>).map((row) =>
      this.mapper.toSummaryDto({
        slug: String(row.slug),
        name: String(row.name),
        itemType: String(row.item_type),
        cost: (row.cost as Record<string, unknown> | null) ?? null,
        weight: (row.weight as string | null) ?? null,
        properties: (row.properties as Record<string, unknown> | null) ?? null,
        description: null,
        id: '0',
      }),
    );
  }
}
