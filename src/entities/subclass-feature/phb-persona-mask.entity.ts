import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PhbSubclassRef } from './phb-subclass-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_persona_mask' })
export class PhbPersonaMask {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @ManyToOne(() => PhbSubclassRef, { nullable: false })
  @JoinColumn({ name: 'subclass_id' })
  subclass!: PhbSubclassRef;
}
