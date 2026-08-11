import { Column, Entity, PrimaryColumn, UpdateDateColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_item_catalog_stats' })
export class PhbItemCatalogStats {
  @PrimaryColumn({ name: 'item_slug', type: 'text' })
  itemSlug!: string;

  @Column({ name: 'view_count', type: 'bigint', default: 0 })
  viewCount!: string;

  @Column({ name: 'purchase_count', type: 'bigint', default: 0 })
  purchaseCount!: string;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
  updatedAt!: Date;
}
