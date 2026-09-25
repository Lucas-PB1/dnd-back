import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectGrantRef } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('spell')
export class PhbEffectSpell extends PhbEffectGrantRef {
  @Column({ type: 'bigint', name: 'spell_id', nullable: true })
  spellId!: string | null;

  spellSlug?: string | null;

  @Column({ type: 'text', name: 'option_key', nullable: true })
  optionKey!: string | null;

  @Column({ type: 'int', name: 'spell_level', nullable: true })
  spellLevel!: number | null;

  @OneToOne(() => PhbEffect, (effect) => effect.spell, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
