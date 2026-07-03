import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_language' })
export class PhbLanguage {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column()
  name!: string;

  @Column({ type: 'text', nullable: true })
  script!: string | null;

  @Column({ name: 'typical_speakers', type: 'text', nullable: true })
  typicalSpeakers!: string | null;

  @Column({ name: 'is_rare' })
  isRare!: boolean;
}
