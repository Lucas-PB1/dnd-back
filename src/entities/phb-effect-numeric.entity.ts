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
  | 'proficiency_bonus_plus_cha'
  | 'attack_ability_mod'
  | 'eight_plus_mod_plus_pb'
  | 'rage_bonus'
  | 'rage_bonus_d6'
  | 'half_level_if_rage'
  | 'ability_mod'
  | 'dice_1d10_plus_level'
  | 'schedule_die_plus_flat'
  | 'level_times_5'
  | 'dice_divine_spark_plus_flat'
  | 'ability_mod_d8'
  | 'dice_2d6_plus_flat'
  | 'dice_2d10_plus_level';

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
