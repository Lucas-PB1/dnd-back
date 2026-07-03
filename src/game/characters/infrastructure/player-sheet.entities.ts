import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'player_character_species_choice' })
export class PlayerCharacterSpeciesChoice {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'choice_kind' })
  choiceKind!: string;

  @Column({ name: 'choice_slug' })
  choiceSlug!: string;
}

@Entity({ schema: 'rpg', name: 'player_character_subclass_option' })
export class PlayerCharacterSubclassOption {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'option_key' })
  optionKey!: string;

  @Column({ name: 'value_id' })
  valueId!: string;
}

@Entity({ schema: 'rpg', name: 'player_character_feat' })
export class PlayerCharacterFeat {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'feat_slug' })
  featSlug!: string;
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
