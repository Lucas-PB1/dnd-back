import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_species_armor_preset' })
export class PhbSpeciesArmorPreset {
  @PrimaryColumn({ name: 'species_id', type: 'bigint' })
  speciesId!: string;

  @PrimaryColumn({ name: 'preset_slug', type: 'text' })
  presetSlug!: string;

  @Column({ type: 'text' })
  label!: string;

  @Column({ name: 'base_ac', type: 'int' })
  baseAc!: number;

  @Column({ name: 'ability_a_slug', type: 'text' })
  abilityASlug!: string;

  @Column({ name: 'ability_a_cap', type: 'int', nullable: true })
  abilityACap!: number | null;

  @Column({ name: 'ability_b_slug', type: 'text', nullable: true })
  abilityBSlug!: string | null;

  @Column({ name: 'ability_b_cap', type: 'int', nullable: true })
  abilityBCap!: number | null;

  @Column({ name: 'pick_mode', type: 'text' })
  pickMode!: 'single' | 'max_of';

  @Column({ name: 'counts_as_worn_armor', type: 'boolean', default: false })
  countsAsWornArmor!: boolean;
}
