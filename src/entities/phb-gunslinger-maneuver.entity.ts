import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PhbSubclassRef } from './phb-subclass-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_gunslinger_maneuver' })
export class PhbGunslingerManeuver {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ name: 'effect_kind', type: 'text' })
  effectKind!: string;

  @Column({ name: 'risk_cost', type: 'int' })
  riskCost!: number;

  @Column({ name: 'from_level', type: 'int' })
  fromLevel!: number;

  @ManyToOne(() => PhbSubclassRef, { nullable: true })
  @JoinColumn({ name: 'subclass_id' })
  subclass!: PhbSubclassRef | null;
}
