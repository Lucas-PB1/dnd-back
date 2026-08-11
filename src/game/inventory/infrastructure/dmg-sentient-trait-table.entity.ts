import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

export type SentientTraitKind =
  | 'alignment'
  | 'communication'
  | 'senses'
  | 'special_purpose'
  | 'ability_scores';

@Entity({ schema: 'rpg', name: 'dmg_sentient_trait_table' })
export class DmgSentientTraitTable {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text' })
  kind!: SentientTraitKind;

  @Column({ name: 'roll_min', type: 'smallint' })
  rollMin!: number;

  @Column({ name: 'roll_max', type: 'smallint' })
  rollMax!: number;

  @Column({ type: 'text' })
  slug!: string;

  @Column({ name: 'summary_pt', type: 'text' })
  summaryPt!: string;

  @Column({ type: 'jsonb', default: () => "'{}'" })
  payload!: Record<string, unknown>;
}
