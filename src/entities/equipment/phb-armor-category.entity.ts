import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_armor_category' })
export class PhbArmorCategory {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', name: 'don_doff', nullable: true })
  donDoff!: string | null;

  @Column({ type: 'int', name: 'sort_order' })
  sortOrder!: number;
}
