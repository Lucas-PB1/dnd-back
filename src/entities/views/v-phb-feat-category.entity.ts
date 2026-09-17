import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_feat_category' })
export class VPhbFeatCategory {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn({ name: 'type_label' })
  typeLabel!: string;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
