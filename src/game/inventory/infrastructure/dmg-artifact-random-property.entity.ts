import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

export type ArtifactRandomPropertyKind =
  | 'minor_beneficial'
  | 'major_beneficial'
  | 'minor_detrimental'
  | 'major_detrimental';

@Entity({ schema: 'rpg', name: 'dmg_artifact_random_property' })
export class DmgArtifactRandomProperty {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text' })
  kind!: ArtifactRandomPropertyKind;

  @Column({ name: 'roll_min', type: 'smallint' })
  rollMin!: number;

  @Column({ name: 'roll_max', type: 'smallint' })
  rollMax!: number;

  @Column({ type: 'text' })
  slug!: string;

  @Column({ name: 'summary_pt', type: 'text' })
  summaryPt!: string;

  @Column({ type: 'jsonb', default: () => "'{}'" })
  effect!: Record<string, unknown>;
}
