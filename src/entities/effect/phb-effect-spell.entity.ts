import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_spell' })
export class PhbEffectSpell {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'bigint', name: 'spell_id', nullable: true })
  spellId!: string | null;

  /** Resolvido no LoadEffectCatalog (não é coluna SQL). */
  spellSlug?: string | null;

  @Column({ type: 'text', name: 'option_key', nullable: true })
  optionKey!: string | null;

  @Column({ type: 'int', name: 'spell_level', nullable: true })
  spellLevel!: number | null;

  @OneToOne(() => PhbEffect, (effect) => effect.spell, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
