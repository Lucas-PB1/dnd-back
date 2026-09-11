import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_feat' })
export class PhbEffectFeat {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

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
