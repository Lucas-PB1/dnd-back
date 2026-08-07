import { ViewEntity, ViewColumn } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_condition' })
export class PhbCondition {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;
}
