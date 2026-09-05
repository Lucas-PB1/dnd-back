import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

export type EffectCastEconomyKind =
  | 'at_will'
  | 'once_per_long_rest'
  | 'slot_only';

export type EffectUsesFormula = 'fixed' | 'proficiency_bonus';

@Entity({ schema: 'rpg', name: 'phb_effect_cast_economy' })
export class PhbEffectCastEconomy {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text' })
  economy!: EffectCastEconomyKind;

  @Column({ type: 'text', name: 'uses_formula', default: 'fixed' })
  usesFormula!: EffectUsesFormula;

  @Column({ type: 'int', name: 'fixed_uses', nullable: true })
  fixedUses!: number | null;

  @OneToOne(() => PhbEffect, (effect) => effect.castEconomy, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
