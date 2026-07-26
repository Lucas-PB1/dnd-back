import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_unarmored_defense' })
export class VPhbUnarmoredDefense {
  @ViewColumn({ name: 'source_kind' })
  sourceKind!: string;

  @ViewColumn({ name: 'source_slug' })
  sourceSlug!: string;

  @ViewColumn({ name: 'label' })
  label!: string;

  @ViewColumn({ name: 'second_ability_slug' })
  secondAbilitySlug!: string;

  @ViewColumn({ name: 'allows_shield' })
  allowsShield!: boolean;
}
