import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

export type EffectDamageAppliesTo = 'unarmed' | 'weapon';

@Entity({ schema: 'rpg', name: 'phb_effect_damage_die' })
export class PhbEffectDamageDie {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'applies_to' })
  appliesTo!: EffectDamageAppliesTo;

  @Column({ type: 'text' })
  die!: string;

  @OneToOne(() => PhbEffect, (effect) => effect.damageDie, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
