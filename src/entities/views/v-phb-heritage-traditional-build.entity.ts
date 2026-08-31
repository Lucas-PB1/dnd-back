import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_heritage_traditional_build' })
export class VPhbHeritageTraditionalBuild {
  @ViewColumn({ name: 'heritage_slug' })
  heritageSlug!: string;

  @ViewColumn({ name: 'trait_slug' })
  traitSlug!: string;

  @ViewColumn({ name: 'trait_name' })
  traitName!: string;

  @ViewColumn({ name: 'category' })
  category!: string;

  @ViewColumn({ name: 'category_hint' })
  categoryHint!: string;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
