import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_wild_shape_known_band' })
export class PhbWildShapeKnownBand {
  @PrimaryColumn({ name: 'min_level', type: 'int' })
  minLevel!: number;

  @Column({ name: 'forms_known', type: 'int' })
  formsKnown!: number;
}
