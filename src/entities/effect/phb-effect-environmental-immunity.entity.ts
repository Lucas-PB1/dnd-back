import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectSenseEnv } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('environmental_immunity')
export class PhbEffectEnvironmentalImmunity extends PhbEffectSenseEnv {
  @Column({ type: 'text', name: 'hazard_slug' })
  hazardSlug!: string;

  @OneToOne(() => PhbEffect, (effect) => effect.environmentalImmunity, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
