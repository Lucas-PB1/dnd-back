import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_alignment' })
export class PhbAlignment {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column()
  name!: string;

  @Column({ type: 'text', nullable: true })
  abbreviation!: string | null;

  @Column({ type: 'text', nullable: true })
  description!: string | null;
}
