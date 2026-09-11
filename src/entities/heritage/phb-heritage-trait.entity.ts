import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_heritage_trait' })
export class PhbHeritageTrait {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ name: 'anchor_id', type: 'text' })
  anchorId!: string;

  @Column({ type: 'text' })
  category!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ name: 'benefit_base', type: 'text' })
  benefitBase!: string;

  @Column({ name: 'benefit_improved', type: 'text', nullable: true })
  benefitImproved!: string | null;

  @Column({ name: 'improved_name', type: 'text', nullable: true })
  improvedName!: string | null;

  @Column({ name: 'max_takes', type: 'int', nullable: true })
  maxTakes!: number | null;

  @Column({ name: 'take_mode', type: 'text', default: 'stack' })
  takeMode!: string;
}
