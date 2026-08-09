import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_metamagic' })
export class PhbMetamagic {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column()
  name!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ type: 'smallint' })
  cost!: number;

  @Column({ name: 'stacks_with_other', type: 'boolean', default: false })
  stacksWithOther!: boolean;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;
}
