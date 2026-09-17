import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_weapon_category' })
export class VPhbWeaponCategory {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
