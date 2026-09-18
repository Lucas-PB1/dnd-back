import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { PhbEffect } from './phb-effect.entity';

@Entity({ schema: 'rpg', name: 'phb_effect_temp_hp' })
export class PhbEffectTempHp {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;

  @Column({ type: 'boolean', name: 'consume_spell_slot', default: false })
  consumeSpellSlot!: boolean;

  @Column({ type: 'int', name: 'amount_per_slot_level', nullable: true })
  amountPerSlotLevel!: number | null;

  @Column({ type: 'boolean', name: 'ward_temp_hp_cap', default: false })
  wardTempHpCap!: boolean;

  @OneToOne(() => PhbEffect, (effect) => effect.tempHp, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'effect_id' })
  effect!: PhbEffect;
}
