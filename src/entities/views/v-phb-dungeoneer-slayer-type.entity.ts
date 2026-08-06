import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_dungeoneer_slayer_type' })
export class VPhbDungeoneerSlayerType {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  label!: string;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
