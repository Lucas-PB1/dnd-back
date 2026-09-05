import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_save_advantage' })
export class PhbEffectSaveAdvantage {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'condition_slug', nullable: true })
  conditionSlug!: string | null;

  @Column({ type: 'text', name: 'ability_slugs', array: true, nullable: true })
  abilitySlugs!: string[] | null;

  @OneToOne(() => PhbEffect, (effect) => effect.saveAdvantage, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
