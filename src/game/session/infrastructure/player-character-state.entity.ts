import { Entity, Column, PrimaryColumn } from 'typeorm';

export type SpellSlotsUsed = Record<string, number>;
export type ResourcesUsed = Record<string, number>;
export type GrantedSpellUses = Record<string, number>;

@Entity({ schema: 'rpg', name: 'player_character_state' })
export class PlayerCharacterState {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ name: 'spell_slots_used', type: 'jsonb', default: {} })
  spellSlotsUsed!: SpellSlotsUsed;

  @Column({ name: 'resources_used', type: 'jsonb', default: {} })
  resourcesUsed!: ResourcesUsed;

  @Column({ name: 'granted_spell_uses', type: 'jsonb', default: {} })
  grantedSpellUses!: GrantedSpellUses;

  @Column({ name: 'high_elf_cantrip_swap_available', type: 'boolean', default: false })
  highElfCantripSwapAvailable!: boolean;

  @Column({ name: 'concentrating_on', type: 'text', nullable: true })
  concentratingOn!: string | null;

  @Column({ type: 'text', array: true, default: [] })
  conditions!: string[];

  @Column({ name: 'temp_hp', type: 'int', default: 0 })
  tempHp!: number;

  @Column({ name: 'hit_dice_current', type: 'int', default: 0 })
  hitDiceCurrent!: number;

  @Column({ name: 'death_save_successes', type: 'int', default: 0 })
  deathSaveSuccesses!: number;

  @Column({ name: 'death_save_failures', type: 'int', default: 0 })
  deathSaveFailures!: number;

  @Column({ type: 'boolean', default: false })
  inspiration!: boolean;

  @Column({ name: 'firearm_chambers', type: 'jsonb', default: {} })
  firearmChambers!: Record<string, number>;

  @Column({ name: 'rage_active', type: 'boolean', default: false })
  rageActive!: boolean;

  @Column({ name: 'reckless_active', type: 'boolean', default: false })
  recklessActive!: boolean;

  @Column({ name: 'persona_masks', type: 'jsonb', default: [] })
  personaMasks!: string[];

  @Column({ name: 'bestial_aspect_level', type: 'int', default: 0 })
  bestialAspectLevel!: number;

  @Column({ name: 'missile_shield_armed', type: 'boolean', default: false })
  missileShieldArmed!: boolean;

  @Column({ name: 'giga_missile_armed', type: 'boolean', default: false })
  gigaMissileArmed!: boolean;

  @Column({ name: 'starry_form_active', type: 'boolean', default: false })
  starryFormActive!: boolean;

  @Column({ name: 'stellar_constellation', type: 'text', nullable: true })
  stellarConstellation!: string | null;

  @Column({ name: 'aberrant_mutation_active', type: 'text', nullable: true })
  aberrantMutationActive!: string | null;

  @Column({ name: 'boarded_actor_id', type: 'uuid', nullable: true })
  boardedActorId!: string | null;

  @Column({ name: 'mesa_circumstances', type: 'text', array: true, default: [] })
  mesaCircumstances!: string[];
}
