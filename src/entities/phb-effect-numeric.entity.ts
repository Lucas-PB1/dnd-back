import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

export type EffectAmountFormula =
  | 'fixed'
  | 'proficiency_bonus'
  | 'proficiency_bonus_times_2'
  | 'level'
  | 'level_times_2'
  | 'level_div_2'
  | 'dice_pb_d4'
  | 'dice_pb_d6'
  | 'dice_hit_die_plus_pb'
  | 'dice_1d4'
  | 'dice_2d4_plus_flat'
  | 'proficiency_bonus_plus_cha';

@Entity({ schema: 'rpg', name: 'phb_effect_numeric' })
export class PhbEffectNumeric {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'amount_formula' })
  amountFormula!: EffectAmountFormula;

  @Column({ type: 'int', nullable: true })
  flat!: number | null;

  @OneToOne(() => PhbEffect, (effect) => effect.numeric, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
