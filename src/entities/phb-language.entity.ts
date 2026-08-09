import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_language' })
export class PhbLanguage {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text',  unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', nullable: true })
  script!: string | null;

  @Column({ name: 'typical_speakers', type: 'text', nullable: true })
  typicalSpeakers!: string | null;

  @Column({ type: 'boolean', name: 'is_rare' })
  isRare!: boolean;
}
