import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_heritage' })
export class PhbHeritage {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  category!: string;

  @Column({ type: 'text', name: 'creature_type' })
  creatureType!: string;

  @Column({ name: 'size_rule', type: 'text' })
  sizeRule!: string;

  @Column({ name: 'speed_rule', type: 'text' })
  speedRule!: string;

  @Column({ name: 'allows_speed_trade', type: 'boolean', default: false })
  allowsSpeedTrade!: boolean;

  @Column({ name: 'allows_size_choice', type: 'boolean', default: false })
  allowsSizeChoice!: boolean;

  @Column({ type: 'text' })
  description!: string;

  @Column({ type: 'text', nullable: true })
  tagline!: string | null;

  @Column({ type: 'text', nullable: true })
  summary!: string | null;

  @Column({ name: 'image_url', type: 'text', nullable: true })
  imageUrl!: string | null;

  @Column({ name: 'source_meta', type: 'jsonb', nullable: true })
  sourceMeta!: Record<string, unknown> | null;
}
