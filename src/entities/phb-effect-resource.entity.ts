import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_resource' })
export class PhbEffectResource {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'bigint', name: 'resource_id' })
  resourceId!: string;

  @Column({ type: 'text', name: 'max_formula' })
  maxFormula!: string;

  @Column({ type: 'int', name: 'fixed_max', nullable: true })
  fixedMax!: number | null;

  @Column({ type: 'boolean', name: 'recover_one_on_short', default: false })
  recoverOneOnShort!: boolean;

  @Column({ type: 'boolean', name: 'recover_all_on_short', default: false })
  recoverAllOnShort!: boolean;

  @Column({ type: 'boolean', name: 'recover_all_on_long', default: true })
  recoverAllOnLong!: boolean;

  @Column({ type: 'text', name: 'recover_on_long_dice', nullable: true })
  recoverOnLongDice!: string | null;

  @OneToOne(() => PhbEffect, (effect) => effect.resource, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
