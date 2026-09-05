import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_sense' })
export class PhbEffectSense {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

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
