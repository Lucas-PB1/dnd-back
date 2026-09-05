import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_note' })
export class PhbEffectNote {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text' })
  note!: string;

  @OneToOne(() => PhbEffect, (effect) => effect.note, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
