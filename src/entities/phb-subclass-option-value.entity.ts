import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_subclass_option_value' })
export class PhbSubclassOptionValue {
  @PrimaryColumn({ name: 'subclass_id', type: 'bigint' })
  subclassId!: string;

  @PrimaryColumn({ name: 'option_key' })
  optionKey!: string;

  @PrimaryColumn({ name: 'value_id' })
  valueId!: string;

  @Column()
  label!: string;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}

@Entity({ schema: 'rpg', name: 'phb_subclass' })
export class PhbSubclassRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column({ name: 'class_id', type: 'bigint' })
  classId!: string;
}
