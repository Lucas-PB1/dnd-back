import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbItemCatalogStats } from '@entities/phb-item-catalog-stats.entity';

/** Upsert de contadores de view/purchase (tabela dedicada, fora de phb_item). */
@Injectable()
export class RecordItemCatalogStatsService {
  constructor(
    @InjectRepository(PhbItemCatalogStats)
    private readonly stats: Repository<PhbItemCatalogStats>,
  ) {}

  async recordView(itemSlug: string): Promise<void> {
    await this.bump(itemSlug, 'view_count');
  }

  async recordPurchase(itemSlug: string, quantity = 1): Promise<void> {
    const delta = Math.max(1, Math.trunc(quantity) || 1);
    await this.bump(itemSlug, 'purchase_count', delta);
  }

  async recordPurchases(
    lines: ReadonlyArray<{ itemSlug: string; quantity: number }>,
  ): Promise<void> {
    for (const line of lines) {
      await this.recordPurchase(line.itemSlug, line.quantity);
    }
  }

  private async bump(
    itemSlug: string,
    column: 'view_count' | 'purchase_count',
    delta = 1,
  ): Promise<void> {
    await this.stats.query(
      `INSERT INTO rpg.phb_item_catalog_stats (item_slug, ${column}, updated_at)
       VALUES ($1, $2, now())
       ON CONFLICT (item_slug) DO UPDATE
         SET ${column} = rpg.phb_item_catalog_stats.${column} + $2,
             updated_at = now()`,
      [itemSlug, delta],
    );
  }
}
