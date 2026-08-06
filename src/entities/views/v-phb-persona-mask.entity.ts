import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_persona_mask' })
export class VPhbPersonaMask {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;
}
