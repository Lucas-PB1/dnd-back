import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_equipment' })
export class VPhbClassEquipment {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'package_slug' })
  packageSlug!: string;

  @ViewColumn({ name: 'package_label' })
  packageLabel!: string;

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

  @ViewColumn({ name: 'gold_amount' })
  goldAmount!: number | null;
}
