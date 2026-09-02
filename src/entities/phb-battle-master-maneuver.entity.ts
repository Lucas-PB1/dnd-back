import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_battle_master_maneuver' })
export class PhbBattleMasterManeuver {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ type: 'text' })
  timing!: string;

  @Column({ name: 'adds_to_damage', type: 'boolean' })
  addsToDamage!: boolean;

  @Column({ name: 'adds_to_attack', type: 'boolean' })
  addsToAttack!: boolean;
}
