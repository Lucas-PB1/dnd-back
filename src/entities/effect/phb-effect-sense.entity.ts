import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectSenseEnv } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('sense')
export class PhbEffectSense extends PhbEffectSenseEnv {
  @Column({ type: 'text', name: 'sense_slug' })
  senseSlug!: string;

  @Column({ type: 'int', name: 'range_ft' })
  rangeFt!: number;

  @Column({ type: 'int', name: 'duration_minutes', nullable: true })
  durationMinutes!: number | null;

  @OneToOne(() => PhbEffect, (effect) => effect.sense, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
