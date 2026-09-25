import { ChildEntity, Column, JoinColumn, OneToOne } from 'typeorm';
import { PhbEffectScalar } from './phb-effect-payload-groups.entity';
import { PhbEffect } from './phb-effect.entity';

@ChildEntity('purchase_discount')
export class PhbEffectPurchaseDiscount extends PhbEffectScalar {
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
