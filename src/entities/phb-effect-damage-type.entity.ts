import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_damage_type' })
export class PhbEffectDamageType {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'damage_type_slug', nullable: true })
  damageTypeSlug!: string | null;

  @Column({ type: 'text', name: 'option_key', nullable: true })
  optionKey!: string | null;

  @OneToOne(() => PhbEffect, (effect) => effect.damageType, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
