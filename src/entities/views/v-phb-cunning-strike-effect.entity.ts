import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_cunning_strike_effect' })
export class VPhbCunningStrikeEffect {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  cost!: number;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'save_ability' })
  saveAbility!: string | null;

  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string | null;

  @ViewColumn()
  note!: string;
}
