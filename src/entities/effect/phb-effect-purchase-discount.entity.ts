import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_purchase_discount' })
export class PhbEffectPurchaseDiscount {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'int', name: 'percent_off' })
  percentOff!: number;

  @Column({ type: 'boolean', name: 'non_magic_only', default: true })
  nonMagicOnly!: boolean;

  @Column({ type: 'boolean', name: 'food_drink_only', default: false })
  foodDrinkOnly!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.purchaseDiscount, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
