import { Entity, PrimaryColumn, Column, OneToOne, JoinColumn } from 'typeorm';
import { PhbItem } from './phb-item.entity';

@Entity({ schema: 'rpg', name: 'phb_weapon' })
export class PhbWeapon {
  @PrimaryColumn({ type: 'bigint', name: 'item_id' })
  itemId!: string;

  @OneToOne(() => PhbItem)
  @JoinColumn({ name: 'item_id' })
  item!: PhbItem;

  @Column({ type: 'varchar' })
  category!: string;

  @Column({ type: 'text', nullable: true })
  damage!: string | null;

  @Column({ name: 'damage_type', type: 'text', nullable: true })
  damageType!: string | null;
}
