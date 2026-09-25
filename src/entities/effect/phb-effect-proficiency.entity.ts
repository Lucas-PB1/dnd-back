import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectGrantRef } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

export type EffectProficiencyKind = 'skill' | 'tool' | 'instrument';

@ChildEntity('proficiency')
export class PhbEffectProficiency extends PhbEffectGrantRef {
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
