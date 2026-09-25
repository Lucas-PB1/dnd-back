import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectScalar } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('companion')
export class PhbEffectCompanion extends PhbEffectScalar {
  @Column({ type: 'boolean', name: 'restore_hp', default: false })
  restoreHp!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.companion, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
