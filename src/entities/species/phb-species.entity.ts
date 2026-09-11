import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_species' })
export class PhbSpecies {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', nullable: true })
  tagline!: string | null;

  @Column({ type: 'text', nullable: true })
  summary!: string | null;

  @Column({ type: 'text',  name: 'creature_type' })
  creatureType!: string;

  @Column({ type: 'text' })
  size!: string;

  @Column({ type: 'text' })
  speed!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ name: 'source_meta', type: 'jsonb', nullable: true })
  sourceMeta!: Record<string, unknown> | null;

  @Column({ name: 'image_url', type: 'text', nullable: true })
  imageUrl!: string | null;
}
