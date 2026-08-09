import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_fighting_style' })
export class PhbFightingStyle {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  description!: string;
}
