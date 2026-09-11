import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_save' })
export class PhbEffectSave {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'save_ability' })
  saveAbility!: string;

  @Column({ type: 'text', name: 'dc_ability', nullable: true })
  dcAbility!: string | null;

  @Column({ type: 'text', name: 'dc_formula' })
  dcFormula!: string;

  @OneToOne(() => PhbEffect, (effect) => effect.save, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
