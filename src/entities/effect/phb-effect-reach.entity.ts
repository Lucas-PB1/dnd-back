import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectScalar } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('reach')
export class PhbEffectReach extends PhbEffectScalar {
  @Column({ type: 'int', name: 'bonus_ft' })
  bonusFt!: number;

  @Column({
    type: 'text',
    name: 'exclude_property_slugs',
    array: true,
    nullable: true,
  })
  excludePropertySlugs!: string[] | null;

  @OneToOne(() => PhbEffect, (effect) => effect.reach, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
