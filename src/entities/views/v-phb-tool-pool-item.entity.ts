import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_tool_pool_item' })
export class VPhbToolPoolItem {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  pool!: string;
}
