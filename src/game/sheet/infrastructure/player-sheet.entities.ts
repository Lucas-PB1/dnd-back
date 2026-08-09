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
