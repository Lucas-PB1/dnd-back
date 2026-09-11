import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_combat_mod' })
export class PhbEffectCombatMod {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'mod_kind' })
  modKind!: 'hp_bonus' | 'unarmored_defense';

  @Column({ type: 'int', name: 'flat_bonus', default: 0 })
  flatBonus!: number;

  @Column({ type: 'int', name: 'per_level_bonus', default: 0 })
  perLevelBonus!: number;

  @Column({ type: 'int', name: 'from_level', default: 1 })
  fromLevel!: number;

  @Column({ type: 'text', name: 'second_ability_slug', nullable: true })
  secondAbilitySlug!: string | null;

  @Column({ type: 'boolean', name: 'allows_shield', default: false })
  allowsShield!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.combatMod, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
