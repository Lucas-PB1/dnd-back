import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_species' })
export class PhbSpecies {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column()
  name!: string;

  @Column({ type: 'text', nullable: true })
  tagline!: string | null;

  @Column({ type: 'text', nullable: true })
  summary!: string | null;

  @Column({ name: 'creature_type' })
  creatureType!: string;

  @Column()
  size!: string;

  @Column()
  speed!: string;

  @Column()
  description!: string;

  @Column({ name: 'source_meta', type: 'jsonb', nullable: true })
  sourceMeta!: Record<string, unknown> | null;
}
