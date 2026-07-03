import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { PhbSpecies } from './phb-species.entity';

@Entity({ schema: 'rpg', name: 'phb_species_trait' })
export class PhbSpeciesTrait {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @ManyToOne(() => PhbSpecies)
  @JoinColumn({ name: 'species_id' })
  species!: PhbSpecies;

  @Column()
  name!: string;

  @Column()
  description!: string;

  @Column({ name: 'choice_kind', type: 'varchar', nullable: true })
  choiceKind!: string | null;
}
