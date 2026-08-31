import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_economy_action' })
export class VPhbClassEconomyAction {
  @ViewColumn({ name: 'action_id' })
  actionId!: string;

  @ViewColumn({ name: 'class_slug' })
  classSlug!: string | null;

  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string | null;

  @ViewColumn({ name: 'species_slug' })
  speciesSlug!: string | null;

  @ViewColumn({ name: 'feat_slug' })
  featSlug!: string | null;

  @ViewColumn({ name: 'item_slug' })
  itemSlug!: string | null;

  @ViewColumn({ name: 'heritage_trait_slug' })
  heritageTraitSlug!: string | null;

  @ViewColumn({ name: 'min_trait_takes' })
  minTraitTakes!: number | null;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  economy!: string;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'resource_slug' })
  resourceSlug!: string | null;

  @ViewColumn({ name: 'free_resource_slug' })
  freeResourceSlug!: string | null;

  @ViewColumn({ name: 'always_spends_resource' })
  alwaysSpendsResource!: boolean;

  @ViewColumn()
  summary!: string | null;

  @ViewColumn()
  description!: string | null;

  @ViewColumn({ name: 'table_action' })
  tableAction!: string | null;

  @ViewColumn({ name: 'spend_amount' })
  spendAmount!: number | null;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string | null;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;

  @ViewColumn({ name: 'requires_option_key' })
  requiresOptionKey!: string | null;

  @ViewColumn({ name: 'requires_option_value' })
  requiresOptionValue!: string | null;
}
