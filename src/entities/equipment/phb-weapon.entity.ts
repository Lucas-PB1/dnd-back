import {
  Entity,
  PrimaryColumn,
  Column,
  OneToOne,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { PhbItem } from './phb-item.entity';
import { PhbWeaponMastery } from './phb-weapon-mastery.entity';

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

  @Column({ name: 'mastery_id', type: 'bigint', nullable: true })
  masteryId!: string | null;

  @ManyToOne(() => PhbWeaponMastery, { nullable: true })
  @JoinColumn({ name: 'mastery_id' })
  mastery!: PhbWeaponMastery | null;
}
