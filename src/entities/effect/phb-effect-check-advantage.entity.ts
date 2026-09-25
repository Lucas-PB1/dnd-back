import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectAdvantage } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('check')
export class PhbEffectCheckAdvantage extends PhbEffectAdvantage {
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
