import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_hp_bonus_source' })
export class VPhbHpBonusSource {
  @ViewColumn({ name: 'source_kind' })
  sourceKind!: string;

  @ViewColumn({ name: 'source_slug' })
  sourceSlug!: string;

  @ViewColumn({ name: 'label' })
  label!: string;

  @ViewColumn({ name: 'flat_bonus' })
  flatBonus!: number;

  @ViewColumn({ name: 'per_level_bonus' })
  perLevelBonus!: number;

  @ViewColumn({ name: 'from_level' })
  fromLevel!: number;
}
