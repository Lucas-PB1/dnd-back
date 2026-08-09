import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_subclass' })
export class PhbSubclassRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;

  @Column({ name: 'class_id', type: 'bigint' })
  classId!: string;
}
