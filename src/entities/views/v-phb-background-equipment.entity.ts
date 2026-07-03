import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_background_equipment' })
export class VPhbBackgroundEquipment {
  @ViewColumn({ name: 'background_slug' })
  backgroundSlug!: string;

  @ViewColumn({ name: 'package_slug' })
  packageSlug!: string;

  @ViewColumn({ name: 'package_label' })
  packageLabel!: string;

  @ViewColumn({ name: 'package_gold' })
  packageGold!: number | null;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;

  @ViewColumn({ name: 'item_slug' })
  itemSlug!: string | null;

  @ViewColumn({ name: 'item_name' })
  itemName!: string | null;

  @ViewColumn({ name: 'quantity' })
  quantity!: number | null;

  @ViewColumn({ name: 'choice_text' })
  choiceText!: string | null;
}
