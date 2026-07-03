import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_armor' })
export class VPhbArmor {
  @ViewColumn({ name: 'item_slug' })
  itemSlug!: string;

  @ViewColumn({ name: 'item_name' })
  itemName!: string;

  @ViewColumn({ name: 'category_slug' })
  categorySlug!: string;

  @ViewColumn({ name: 'category_name' })
  categoryName!: string;

  @ViewColumn({ name: 'don_doff' })
  donDoff!: string | null;

  @ViewColumn({ name: 'ac_base' })
  acBase!: number | null;

  @ViewColumn({ name: 'ac_formula' })
  acFormula!: string | null;

  @ViewColumn({ name: 'strength_req' })
  strengthReq!: number | null;

  @ViewColumn({ name: 'stealth_disadvantage' })
  stealthDisadvantage!: boolean;
}
