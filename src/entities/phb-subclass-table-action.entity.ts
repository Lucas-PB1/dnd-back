import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PhbSubclassRef } from './phb-subclass-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_subclass_table_action' })
export class PhbSubclassTableAction {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @ManyToOne(() => PhbSubclassRef, { nullable: false })
  @JoinColumn({ name: 'subclass_id' })
  subclass!: PhbSubclassRef;

  @Column({ type: 'text' })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;

  @Column({ name: 'free_resource_slug', type: 'text', nullable: true })
  freeResourceSlug!: string | null;

  @Column({ name: 'always_spends_pool', type: 'boolean' })
  alwaysSpendsPool!: boolean;

  @Column({ name: 'rolls_pool_die', type: 'boolean' })
  rollsPoolDie!: boolean;

  @Column({ name: 'spends_only_on_success', type: 'boolean' })
  spendsOnlyOnSuccess!: boolean;

  @Column({ name: 'always_pool_cost', type: 'int', nullable: true })
  alwaysPoolCost!: number | null;

  @Column({ name: 'repeat_pool_cost', type: 'int', nullable: true })
  repeatPoolCost!: number | null;
}
