import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_check_advantage' })
export class PhbEffectCheckAdvantage {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'skill_slug', nullable: true })
  skillSlug!: string | null;

  @Column({ type: 'text', name: 'circumstance_tag', nullable: true })
  circumstanceTag!: string | null;

  @Column({ type: 'text', name: 'ability_slug', nullable: true })
  abilitySlug!: string | null;

  @OneToOne(() => PhbEffect, (effect) => effect.checkAdvantage, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
