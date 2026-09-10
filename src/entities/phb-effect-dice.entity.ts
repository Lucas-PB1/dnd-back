import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_dice' })
export class PhbEffectDice {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text' })
  die!: string;

  @Column({ type: 'text', name: 'die_at_level', nullable: true })
  dieAtLevel!: string | null;

  @Column({ type: 'int', name: 'at_level', nullable: true })
  atLevel!: number | null;

  @Column({ type: 'text', name: 'damage_type_slug', nullable: true })
  damageTypeSlug!: string | null;

  @OneToOne(() => PhbEffect, (effect) => effect.dice, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
