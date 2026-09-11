import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PhbClassRef } from './phb-class-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_class_feature' })
export class PhbClassFeature {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @ManyToOne(() => PhbClassRef, { nullable: false })
  @JoinColumn({ name: 'class_id' })
  klass!: PhbClassRef;

  @Column({ type: 'int' })
  level!: number;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  description!: string;
}
