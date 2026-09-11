import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_feat' })
export class PhbFeatRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;
}
