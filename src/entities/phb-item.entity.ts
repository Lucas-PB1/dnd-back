import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_item' })
export class PhbItem {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column({ name: 'item_type' })
  itemType!: string;

  @Column()
  name!: string;

  @Column({ type: 'jsonb', nullable: true })
  cost!: Record<string, unknown> | null;

  @Column({ type: 'text', nullable: true })
  weight!: string | null;

  @Column({ type: 'text', nullable: true })
  description!: string | null;

  @Column({ type: 'jsonb', nullable: true })
  properties!: Record<string, unknown> | null;
}
