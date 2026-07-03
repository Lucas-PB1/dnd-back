import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_condition' })
export class PhbCondition {
  @PrimaryColumn()
  slug!: string;

  @Column()
  name!: string;
}
