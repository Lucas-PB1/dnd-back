import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_subclass_table_action' })
export class VPhbSubclassTableAction {
  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;

  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'free_resource_slug' })
  freeResourceSlug!: string | null;

  @ViewColumn({ name: 'always_spends_pool' })
  alwaysSpendsPool!: boolean;

  @ViewColumn({ name: 'rolls_pool_die' })
  rollsPoolDie!: boolean;

  @ViewColumn({ name: 'spends_only_on_success' })
  spendsOnlyOnSuccess!: boolean;

  @ViewColumn({ name: 'always_pool_cost' })
  alwaysPoolCost!: number | null;

  @ViewColumn({ name: 'repeat_pool_cost' })
  repeatPoolCost!: number | null;
}
