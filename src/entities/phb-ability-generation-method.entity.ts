import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_ability_generation_method' })
export class PhbAbilityGenerationMethod {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column()
  name!: string;

  @Column()
  description!: string;
}
