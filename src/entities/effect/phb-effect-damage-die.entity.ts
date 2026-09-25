import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectDicePayload } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

export type EffectDamageAppliesTo = 'unarmed' | 'weapon';

@ChildEntity('damage_die')
export class PhbEffectDamageDie extends PhbEffectDicePayload {
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
