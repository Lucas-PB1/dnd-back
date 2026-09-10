import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_forced_movement' })
export class PhbEffectForcedMovement {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'int', name: 'distance_m' })
  distanceM!: number;

  @Column({ type: 'text', name: 'max_target_size', nullable: true })
  maxTargetSize!: string | null;

  @OneToOne(() => PhbEffect, (effect) => effect.forcedMovement, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
