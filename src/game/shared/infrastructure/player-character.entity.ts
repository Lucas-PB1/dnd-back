import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

import {
  AbilityScores,
  DEFAULT_ABILITY_SCORES,
} from '../domain/ability-scores';

export type { AbilityScores };
export { DEFAULT_ABILITY_SCORES };

@Entity({ schema: 'rpg', name: 'player_character' })
export class PlayerCharacter {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'int', default: 1 })
  level!: number;

  @Column({ type: 'text',  name: 'class_slug' })
  classSlug!: string;

  @Column({ type: 'text',  name: 'species_slug' })
  speciesSlug!: string;

  @Column({ type: 'text',  name: 'background_slug' })
  backgroundSlug!: string;

  @Column({ name: 'subclass_slug', type: 'text', nullable: true })
  subclassSlug!: string | null;

  @Column({ name: 'alignment_slug', type: 'text', nullable: true })
  alignmentSlug!: string | null;

  @Column({ name: 'ability_scores', type: 'jsonb' })
  abilityScores!: AbilityScores;

  @Column({ name: 'hit_points_max', type: 'int', nullable: true })
  hitPointsMax!: number | null;

  @Column({ name: 'hit_points_current', type: 'int', nullable: true })
  hitPointsCurrent!: number | null;

  @Column({ name: 'ability_generation_method_slug', type: 'text', nullable: true })
  abilityGenerationMethodSlug!: string | null;

  @Column({
    name: 'background_boost_mode',
    type: 'text',
    default: 'plus2plus1',
  })
  backgroundBoostMode!: 'plus2plus1' | 'plus1x3';

  @Column({ name: 'background_boost_plus2_ability_slug', type: 'text', nullable: true })
  backgroundBoostPlus2AbilitySlug!: string | null;

  @Column({ name: 'background_boost_plus1_ability_slug', type: 'text', nullable: true })
  backgroundBoostPlus1AbilitySlug!: string | null;

  @Column({ name: 'background_boost_plus1_slugs', type: 'text', array: true, nullable: true })
  backgroundBoostPlus1Slugs!: string[] | null;

  @Column({ name: 'background_tool_item_slug', type: 'text', nullable: true })
  backgroundToolItemSlug!: string | null;

  @Column({ name: 'coin_copper', type: 'int', default: 0 })
  coinCopper!: number;

  @Column({ name: 'coin_silver', type: 'int', default: 0 })
  coinSilver!: number;

  @Column({ name: 'coin_electrum', type: 'int', default: 0 })
  coinElectrum!: number;

  @Column({ name: 'coin_gold', type: 'int', default: 0 })
  coinGold!: number;

  @Column({ name: 'coin_platinum', type: 'int', default: 0 })
  coinPlatinum!: number;

  @Column({ name: 'session_notes', type: 'text', default: '' })
  sessionNotes!: string;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
