import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_weapon' })
export class PhbEffectWeapon {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'text', name: 'property_slug', nullable: true })
  propertySlug!: string | null;

  @Column({ type: 'int', name: 'range_normal_ft', nullable: true })
  rangeNormalFt!: number | null;

  @Column({ type: 'int', name: 'range_long_ft', nullable: true })
  rangeLongFt!: number | null;

  @OneToOne(() => PhbEffect, (effect) => effect.weapon, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
