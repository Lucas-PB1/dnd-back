import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { PhbAbility } from './phb-ability.entity';

@Entity({ schema: 'rpg', name: 'phb_skill' })
export class PhbSkill {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', nullable: true })
  description!: string | null;

  @ManyToOne(() => PhbAbility, { eager: true })
  @JoinColumn({ name: 'ability_id' })
  ability!: PhbAbility;
}
