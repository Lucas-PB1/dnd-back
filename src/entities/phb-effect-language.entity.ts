import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_language' })
export class PhbEffectLanguage {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

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
