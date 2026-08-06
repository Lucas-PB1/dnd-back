import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_battle_master_maneuver' })
export class VPhbBattleMasterManeuver {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  description!: string;

  @ViewColumn()
  timing!: string;

  @ViewColumn({ name: 'adds_to_damage' })
  addsToDamage!: boolean;

  @ViewColumn({ name: 'adds_to_attack' })
  addsToAttack!: boolean;
}
