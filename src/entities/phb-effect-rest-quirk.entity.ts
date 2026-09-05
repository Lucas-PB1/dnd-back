import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_rest_quirk' })
export class PhbEffectRestQuirk {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'int', name: 'long_rest_hours', default: 8 })
  longRestHours!: number;

  @Column({ type: 'boolean', name: 'no_sleep', default: false })
  noSleep!: boolean;

  @Column({ type: 'boolean', name: 'no_food_drink_air', default: false })
  noFoodDrinkAir!: boolean;

  @Column({ type: 'boolean', name: 'magic_cannot_force_sleep', default: false })
  magicCannotForceSleep!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.restQuirk, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
