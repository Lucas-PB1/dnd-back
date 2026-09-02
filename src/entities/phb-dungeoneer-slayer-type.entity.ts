import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_dungeoneer_slayer_type' })
export class PhbDungeoneerSlayerType {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  label!: string;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
