import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_damage_type' })
export class PhbDamageType {
  @PrimaryColumn({ type: 'text' })
  slug!: string;

  @Column({ name: 'label_pt', type: 'text' })
  labelPt!: string;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
