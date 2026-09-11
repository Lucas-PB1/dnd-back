import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_level_combat_note' })
export class PhbLevelCombatNote {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'owner_kind', type: 'text' })
  ownerKind!: 'class' | 'subclass';

  @Column({ name: 'class_id', type: 'bigint', nullable: true })
  classId!: string | null;

  @Column({ name: 'subclass_id', type: 'bigint', nullable: true })
  subclassId!: string | null;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;

  @Column({ type: 'text' })
  note!: string;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
