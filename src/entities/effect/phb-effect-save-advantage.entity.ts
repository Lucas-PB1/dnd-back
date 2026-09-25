import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectAdvantage } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('save')
export class PhbEffectSaveAdvantage extends PhbEffectAdvantage {
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
