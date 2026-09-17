import { Column, Entity, PrimaryColumn } from 'typeorm';

export type SpellCombatResolutionKind =
  | 'auto_damage'
  | 'spell_attack'
  | 'arena_darkness'
  | 'save_damage'
  | 'heal_combatant';

export type SpellCombatSaveSuccessOutcome = 'none' | 'half' | 'full';

@Entity({ schema: 'rpg', name: 'phb_spell_combat' })
export class PhbSpellCombat {
  @PrimaryColumn({ name: 'spell_slug', type: 'text' })
  spellSlug!: string;

  @Column({ name: 'resolution', type: 'text' })
  resolution!: SpellCombatResolutionKind;

  @Column({ type: 'text' })
  label!: string;

  @Column({ name: 'damage_die', type: 'int', nullable: true })
  damageDie!: number | null;

  @Column({ name: 'flat_per_die', type: 'int', default: 0 })
  flatPerDie!: number;

  @Column({ name: 'auto_unit_base', type: 'int', nullable: true })
  autoUnitBase!: number | null;

  @Column({ name: 'auto_unit_per_slot_above_base', type: 'int', nullable: true })
  autoUnitPerSlotAboveBase!: number | null;

  @Column({ name: 'dice_count_base', type: 'int', nullable: true })
  diceCountBase!: number | null;

  @Column({ name: 'dice_per_slot_above_base', type: 'int', nullable: true })
  dicePerSlotAboveBase!: number | null;

  @Column({ name: 'spell_level', type: 'int', default: 0 })
  spellLevel!: number;

  @Column({ name: 'cantrip_scale', type: 'boolean', default: false })
  cantripScale!: boolean;

  @Column({ name: 'per_die_attack', type: 'boolean', default: false })
  perDieAttack!: boolean;

  @Column({ name: 'include_spellcasting_mod', type: 'boolean', default: false })
  includeSpellcastingMod!: boolean;

  @Column({ name: 'save_success_outcome', type: 'text', nullable: true })
  saveSuccessOutcome!: SpellCombatSaveSuccessOutcome | null;

  @Column({ name: 'save_ability_slug', type: 'text', nullable: true })
  saveAbilitySlug!: string | null;

  @Column({ name: 'damage_type_slug', type: 'text', nullable: true })
  damageTypeSlug!: string | null;
}
