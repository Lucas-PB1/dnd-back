import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_feat_option_def' })
export class PhbFeatOptionDef {
  @PrimaryColumn({ name: 'feat_id', type: 'bigint' })
  featId!: string;

  @PrimaryColumn({ name: 'option_key' })
  optionKey!: string;

  @Column()
  label!: string;

  @Column({ name: 'value_type' })
  valueType!: string;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;

  @Column({ name: 'depends_on_option_key', type: 'text', nullable: true })
  dependsOnOptionKey!: string | null;

  @Column({ name: 'spell_max_level', type: 'int', nullable: true })
  spellMaxLevel!: number | null;

  @Column({ name: 'spell_school_slugs', type: 'text', array: true, nullable: true })
  spellSchoolSlugs!: string[] | null;
}

@Entity({ schema: 'rpg', name: 'phb_feat_option_value' })
export class PhbFeatOptionValue {
  @PrimaryColumn({ name: 'feat_id', type: 'bigint' })
  featId!: string;

  @PrimaryColumn({ name: 'option_key' })
  optionKey!: string;

  @PrimaryColumn({ name: 'value_id' })
  valueId!: string;

  @Column()
  label!: string;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}

@Entity({ schema: 'rpg', name: 'phb_feat' })
export class PhbFeatRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;
}
