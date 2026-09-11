import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

export type EffectProficiencyKind = 'skill' | 'tool' | 'instrument';

@Entity({ schema: 'rpg', name: 'phb_effect_proficiency' })
export class PhbEffectProficiency {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'option_key' })
  optionKey!: string;

  @Column({ type: 'text', name: 'proficiency_kind' })
  proficiencyKind!: EffectProficiencyKind;

  @OneToOne(() => PhbEffect, (effect) => effect.proficiency, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
