import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_beastborne_aspect_benefit' })
export class VPhbBeastborneAspectBenefit {
  @ViewColumn({ name: 'aspect_level' })
  aspectLevel!: number;

  @ViewColumn()
  note!: string;
}
