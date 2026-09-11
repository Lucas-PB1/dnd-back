import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_reach' })
export class PhbEffectReach {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'int', name: 'bonus_ft' })
  bonusFt!: number;

  @Column({
    type: 'text',
    name: 'exclude_property_slugs',
    array: true,
    nullable: true,
  })
  excludePropertySlugs!: string[] | null;

  @OneToOne(() => PhbEffect, (effect) => effect.reach, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
