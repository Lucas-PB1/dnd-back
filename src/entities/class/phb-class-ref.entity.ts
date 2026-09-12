import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_class' })
export class PhbClassRef {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ name: 'subclass_unlock_level', type: 'int', default: 3 })
  subclassUnlockLevel!: number;

  @Column({ name: 'fighting_style_unlock_level', type: 'int', nullable: true })
  fightingStyleUnlockLevel!: number | null;

  @Column({ name: 'jack_of_all_trades_level', type: 'int', nullable: true })
  jackOfAllTradesLevel!: number | null;

  @Column({ name: 'weapon_mastery_eligibility', type: 'text', nullable: true })
  weaponMasteryEligibility!: string | null;
}
