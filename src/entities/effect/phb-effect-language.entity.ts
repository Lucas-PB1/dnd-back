import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectGrantRef } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('language')
export class PhbEffectLanguage extends PhbEffectGrantRef {
  @Column({ type: 'text', name: 'option_key', nullable: true })
  optionKey!: string | null;

  @Column({ type: 'text', name: 'language_slug', nullable: true })
  languageSlug!: string | null;

  @Column({ type: 'int', name: 'choice_count', default: 1 })
  choiceCount!: number;

  @OneToOne(() => PhbEffect, (effect) => effect.language, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
