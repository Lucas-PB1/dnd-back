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

  /** Tiros restantes por arma equipada com Recarga: `{ [itemSlug]: remaining }`. */
  @Column({ name: 'firearm_chambers', type: 'jsonb', default: {} })
  firearmChambers!: Record<string, number>;

  /** Fúria do Bárbaro ativa. */
  @Column({ name: 'rage_active', type: 'boolean', default: false })
  rageActive!: boolean;

  /** Ataque Imprudente ativo. */
  @Column({ name: 'reckless_active', type: 'boolean', default: false })
  recklessActive!: boolean;
}
