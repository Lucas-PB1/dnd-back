import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_gunslinger_maneuver' })
export class VPhbGunslingerManeuver {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  description!: string;

  @ViewColumn({ name: 'effect_kind' })
  effectKind!: string;

  @ViewColumn({ name: 'risk_cost' })
  riskCost!: number;

  @ViewColumn({ name: 'from_level' })
  fromLevel!: number;

  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string | null;
}
