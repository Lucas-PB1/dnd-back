import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_beastborne_aspect_benefit' })
export class PhbBeastborneAspectBenefit {
  @PrimaryColumn({ name: 'aspect_level', type: 'int' })
  aspectLevel!: number;

  @Column({ type: 'text' })
  note!: string;
}
