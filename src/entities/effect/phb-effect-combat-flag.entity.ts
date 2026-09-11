import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

export type EffectCombatFlag = 'rage' | 'reckless';

@Entity({ schema: 'rpg', name: 'phb_effect_combat_flag' })
export class PhbEffectCombatFlag {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text' })
  flag!: EffectCombatFlag;

  @Column({ type: 'boolean', name: 'spend_on_enter', default: true })
  spendOnEnter!: boolean;

  @Column({ type: 'boolean', name: 'force_enter', default: false })
  forceEnter!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.combatFlag, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
