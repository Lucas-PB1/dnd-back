import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

/** Leitura mínima de `phb_class` para joins por slug (validação de ficha). */
@Entity({ schema: 'rpg', name: 'phb_class' })
export class PhbClassRef {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ name: 'subclass_unlock_level', type: 'int', default: 3 })
  subclassUnlockLevel!: number;

  @Column({ name: 'weapon_mastery_eligibility', type: 'text', nullable: true })
  weaponMasteryEligibility!: string | null;
}
