import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_wild_shape_cr_band' })
export class PhbWildShapeCrBand {
  @PrimaryColumn({ name: 'min_level', type: 'int' })
  minLevel!: number;

  @Column({ name: 'cr_max', type: 'text' })
  crMax!: string;

  @Column({ name: 'allow_fly', type: 'boolean', default: false })
  allowFly!: boolean;
}
