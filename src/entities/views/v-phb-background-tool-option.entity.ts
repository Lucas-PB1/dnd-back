import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_background_tool_option' })
export class VPhbBackgroundToolOption {
  @ViewColumn({ name: 'background_slug' })
  backgroundSlug!: string;

  @ViewColumn({ name: 'item_slug' })
  itemSlug!: string;

  @ViewColumn({ name: 'item_name' })
  itemName!: string;

  @ViewColumn({ name: 'category_slug' })
  categorySlug!: string;

  @ViewColumn({ name: 'category_name' })
  categoryName!: string;
}
