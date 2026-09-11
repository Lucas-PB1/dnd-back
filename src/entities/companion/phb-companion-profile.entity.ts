import { Entity, Column, PrimaryColumn, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_companion_profile' })
export class PhbCompanionProfile {
  @PrimaryColumn({ name: 'profile_id', type: 'text' })
  profileId!: string;

  @Column({ name: 'subclass_id', type: 'bigint' })
  subclassId!: string;

  @Column({ name: 'min_level', type: 'int' })
  minLevel!: number;
}

@Entity({ schema: 'rpg', name: 'phb_companion_template_map' })
export class PhbCompanionTemplateMap {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'profile_id', type: 'text' })
  profileId!: string;

  @Column({ name: 'option_matches', type: 'jsonb' })
  optionMatches!: Record<string, string>;

  @Column({ name: 'template_slug', type: 'text' })
  templateSlug!: string;

  @Column({ name: 'variant_label', type: 'text' })
  variantLabel!: string;
}
