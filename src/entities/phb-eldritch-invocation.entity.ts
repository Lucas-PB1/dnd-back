import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_eldritch_invocation' })
export class PhbEldritchInvocation {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ name: 'min_level', type: 'int' })
  minLevel!: number;

  @Column({ name: 'requires_pact_slug', type: 'text', nullable: true })
  requiresPactSlug!: string | null;

  @Column({ name: 'requires_invocation_slug', type: 'text', nullable: true })
  requiresInvocationSlug!: string | null;

  @Column({ type: 'boolean', default: false })
  repeatable!: boolean;

  @Column({ type: 'text' })
  kind!: string;

  @Column({ name: 'granted_spell_slug', type: 'text', nullable: true })
  grantedSpellSlug!: string | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;
}
