import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_combat_note' })
export class PhbCombatNote {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'source_kind', type: 'text' })
  sourceKind!:
    | 'class_level'
    | 'subclass_level'
    | 'heritage_trait'
    | 'transformation_boon';

  @Column({ name: 'class_id', type: 'bigint', nullable: true })
  classId!: string | null;

  @Column({ name: 'subclass_id', type: 'bigint', nullable: true })
  subclassId!: string | null;

  @Column({ name: 'unlock_level', type: 'int', nullable: true })
  unlockLevel!: number | null;

  @Column({ name: 'trait_id', type: 'bigint', nullable: true })
  traitId!: string | null;

  @Column({ name: 'min_trait_takes', type: 'int', nullable: true })
  minTraitTakes!: number | null;

  @Column({ name: 'boon_id', type: 'text', nullable: true })
  boonId!: string | null;

  @Column({ name: 'name_pt', type: 'text', nullable: true })
  namePt!: string | null;

  @Column({ type: 'text', array: true, default: '{}' })
  economy!: string[];

  @Column({ type: 'text', nullable: true })
  note!: string | null;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
