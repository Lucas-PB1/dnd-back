import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PhbSubclassRef } from './phb-subclass-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_cunning_strike_effect' })
export class PhbCunningStrikeEffect {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'int' })
  cost!: number;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;

  @Column({ name: 'save_ability', type: 'text', nullable: true })
  saveAbility!: string | null;

  @ManyToOne(() => PhbSubclassRef, { nullable: true })
  @JoinColumn({ name: 'subclass_id' })
  subclass!: PhbSubclassRef | null;

  @Column({ type: 'text' })
  note!: string;
}
