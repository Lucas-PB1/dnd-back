import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectGrantRef } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('feat')
export class PhbEffectFeat extends PhbEffectGrantRef {
  @Column({ type: 'text', name: 'option_key' })
  optionKey!: string;

  @Column({ type: 'text', name: 'feat_category', default: 'origin' })
  featCategory!: string;

  @OneToOne(() => PhbEffect, (effect) => effect.feat, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
