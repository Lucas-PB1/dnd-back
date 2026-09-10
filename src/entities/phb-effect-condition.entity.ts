import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_condition' })
export class PhbEffectCondition {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'condition_slug', nullable: true })
  conditionSlug!: string | null;

  @Column({ type: 'text', name: 'pending_kind', nullable: true })
  pendingKind!: string | null;

  @OneToOne(() => PhbEffect, (effect) => effect.condition, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
