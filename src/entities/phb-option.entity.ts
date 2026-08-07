import { Entity, Column, PrimaryColumn } from 'typeorm';

// Lote C: unified option_scope enum
export type OptionScope = 'subclass' | 'species' | 'feat' | 'class';

@Entity({ schema: 'rpg', name: 'phb_option_def' })
export class PhbOptionDef {
  @PrimaryColumn({ type: 'text' })
  scope!: OptionScope;

  @PrimaryColumn({ name: 'owner_id', type: 'bigint' })
  ownerId!: string;

  @PrimaryColumn({ name: 'option_key' })
  optionKey!: string;

  @Column({ name: 'value_type' })
  valueType!: string;

  @Column({ nullable: true })
  label!: string | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;

  @Column({ name: 'unlock_level', type: 'int', nullable: true })
  unlockLevel!: number | null;

  @Column({ name: 'depends_on_option_key', type: 'text', nullable: true })
  dependsOnOptionKey!: string | null;

  @Column({ name: 'spell_max_level', type: 'int', nullable: true })
  spellMaxLevel!: number | null;

  @Column({ name: 'spell_school_slugs', type: 'text', array: true, nullable: true })
  spellSchoolSlugs!: string[] | null;

  @Column({ name: 'spell_ritual_only', type: 'boolean', default: false })
  spellRitualOnly!: boolean;
}

@Entity({ schema: 'rpg', name: 'phb_option_value' })
export class PhbOptionValue {
  @PrimaryColumn({ type: 'text' })
  scope!: OptionScope;

  @PrimaryColumn({ name: 'owner_id', type: 'bigint' })
  ownerId!: string;

  @PrimaryColumn({ name: 'option_key' })
  optionKey!: string;

  @PrimaryColumn({ name: 'value_id' })
  valueId!: string;

  @Column()
  label!: string;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;

  @Column({ type: 'text', nullable: true })
  benefit!: string | null;

  @Column({ name: 'level1_benefit', type: 'text', nullable: true })
  level1Benefit!: string | null;

  @Column({ name: 'damage_type', type: 'text', nullable: true })
  damageType!: string | null;

  @Column({ name: 'spell_level1_id', type: 'bigint', nullable: true })
  spellLevel1Id!: string | null;

  @Column({ name: 'spell_level3_id', type: 'bigint', nullable: true })
  spellLevel3Id!: string | null;

  @Column({ name: 'spell_level5_id', type: 'bigint', nullable: true })
  spellLevel5Id!: string | null;

  @Column({ name: 'spell_1_id', type: 'bigint', nullable: true })
  spell1Id!: string | null;

  @Column({ name: 'spell_2_id', type: 'bigint', nullable: true })
  spell2Id!: string | null;
}
