import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

export interface AbilityScores {
  forca: number;
  destreza: number;
  constituicao: number;
  inteligencia: number;
  sabedoria: number;
  carisma: number;
}

export const DEFAULT_ABILITY_SCORES: AbilityScores = {
  forca: 10,
  destreza: 10,
  constituicao: 10,
  inteligencia: 10,
  sabedoria: 10,
  carisma: 10,
};

@Entity({ schema: 'rpg', name: 'player_character' })
export class PlayerCharacter {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @Column()
  name!: string;

  @Column({ default: 1 })
  level!: number;

  @Column({ name: 'class_slug' })
  classSlug!: string;

  @Column({ name: 'species_slug' })
  speciesSlug!: string;

  @Column({ name: 'background_slug' })
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

  @Column({ name: 'background_boost_plus2_ability_slug', type: 'text', nullable: true })
  backgroundBoostPlus2AbilitySlug!: string | null;

  @Column({ name: 'background_boost_plus1_ability_slug', type: 'text', nullable: true })
  backgroundBoostPlus1AbilitySlug!: string | null;

  @Column({ name: 'background_tool_item_slug', type: 'text', nullable: true })
  backgroundToolItemSlug!: string | null;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
