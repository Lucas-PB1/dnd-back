import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PhbClassRef } from './phb-class-ref.entity';
import { PhbSubclassRef } from './phb-subclass-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_class_panel_action' })
export class PhbClassPanelAction {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'panel_key', type: 'text', unique: true })
  panelKey!: string;

  @ManyToOne(() => PhbClassRef, { nullable: false })
  @JoinColumn({ name: 'class_id' })
  klass!: PhbClassRef;

  @ManyToOne(() => PhbSubclassRef, { nullable: true })
  @JoinColumn({ name: 'subclass_id' })
  subclass!: PhbSubclassRef | null;

  @Column({ type: 'text' })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', nullable: true })
  title!: string | null;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;

  @Column({ name: 'resource_slug', type: 'text', nullable: true })
  resourceSlug!: string | null;

  @Column({ type: 'text' })
  section!: string;

  @Column({ name: 'spends_focus', type: 'boolean' })
  spendsFocus!: boolean;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
