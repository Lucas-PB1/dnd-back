import { Entity, Column, PrimaryColumn, PrimaryGeneratedColumn } from 'typeorm';
import { OptionScope } from '@entities/phb-option.entity';

@Entity({ schema: 'rpg', name: 'player_character_species_choice' })
export class PlayerCharacterSpeciesChoice {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'choice_kind' })
  choiceKind!: string;

  @Column({ name: 'choice_slug' })
  choiceSlug!: string;
}

// Lote C: unified runtime option storage
@Entity({ schema: 'rpg', name: 'player_character_option' })
export class PlayerCharacterOption {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ type: 'text' })
  scope!: OptionScope;

  @Column({ name: 'owner_slug', type: 'text' })
  ownerSlug!: string;

  @Column({ name: 'option_key', type: 'text' })
  optionKey!: string;

  @Column({ name: 'value_id', type: 'text' })
  valueId!: string;

  @Column({ name: 'instance_index', type: 'int', default: 0 })
  instanceIndex!: number;
}

@Entity({ schema: 'rpg', name: 'player_character_feat' })
export class PlayerCharacterFeat {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'feat_slug' })
  featSlug!: string;

  @PrimaryColumn({ name: 'instance_index', type: 'int' })
  instanceIndex!: number;
}

@Entity({ schema: 'rpg', name: 'player_character_spell' })
export class PlayerCharacterSpell {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'spell_slug' })
  spellSlug!: string;

  @PrimaryColumn({ name: 'list_type' })
  listType!: string;
}

@Entity({ schema: 'rpg', name: 'player_character_equipment' })
export class PlayerCharacterEquipment {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'source' })
  source!: string;

  @PrimaryColumn({ name: 'sort_order', type: 'int' })
  sortOrder!: number;

  @Column({ name: 'package_slug' })
  packageSlug!: string;

  @Column({ name: 'package_id', type: 'bigint', nullable: true })
  packageId!: number | null;

  @Column({ name: 'item_slug', type: 'text', nullable: true })
  itemSlug!: string | null;

  @Column({ type: 'int', default: 1 })
  quantity!: number;
}

@Entity({ schema: 'rpg', name: 'player_character_language' })
export class PlayerCharacterLanguage {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'language_slug' })
  languageSlug!: string;
}

export type PlayerCharacterThreadStatus =
  | 'active'
  | 'completed'
  | 'abandoned';

export type CharacterThreadMilestoneRank =
  | 'least'
  | 'lesser'
  | 'greater'
  | 'superior';

@Entity({ schema: 'rpg', name: 'player_character_thread' })
export class PlayerCharacterThread {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ name: 'thread_slug', type: 'text' })
  threadSlug!: string;

  @Column({ type: 'text' })
  status!: PlayerCharacterThreadStatus;

  @Column({ name: 'goal_index', type: 'int', nullable: true })
  goalIndex!: number | null;

  @Column({ name: 'goal_text', type: 'text', nullable: true })
  goalText!: string | null;

  @Column({ name: 'started_at', type: 'timestamptz' })
  startedAt!: Date;

  @Column({ name: 'ended_at', type: 'timestamptz', nullable: true })
  endedAt!: Date | null;
}

@Entity({ schema: 'rpg', name: 'player_character_thread_milestone' })
export class PlayerCharacterThreadMilestone {
  @PrimaryColumn({ name: 'character_thread_id', type: 'uuid' })
  characterThreadId!: string;

  @PrimaryColumn({ type: 'text' })
  rank!: CharacterThreadMilestoneRank;

  @PrimaryColumn({ name: 'benefit_key', type: 'text' })
  benefitKey!: string;

  @Column({ name: 'reached_at', type: 'timestamptz' })
  reachedAt!: Date;
}
