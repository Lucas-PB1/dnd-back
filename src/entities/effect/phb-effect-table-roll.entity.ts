import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_table_roll' })
export class PhbEffectTableRoll {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'int', name: 'result_scale', nullable: true })
  resultScale!: number | null;

  @Column({ type: 'boolean', name: 'apply_bestial_aspect', default: false })
  applyBestialAspect!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.tableRoll, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
