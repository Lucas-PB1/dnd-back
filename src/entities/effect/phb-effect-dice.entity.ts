import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectDicePayload } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('dice')
export class PhbEffectDice extends PhbEffectDicePayload {
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
