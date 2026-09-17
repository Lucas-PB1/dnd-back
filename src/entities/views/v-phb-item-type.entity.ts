import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_item_type' })
export class VPhbItemType {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
