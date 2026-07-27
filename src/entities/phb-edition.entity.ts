import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_edition' })
export class PhbEdition {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column()
  label!: string;

  @Column({ default: 'Livro do Jogador 2024' })
  book!: string;

  @Column({ name: 'language', default: 'pt-BR' })
  language!: string;

  @Column({ name: 'extracted_at', type: 'timestamptz', nullable: true })
  extractedAt!: Date | null;

  @Column({ type: 'text', nullable: true })
  notes!: string | null;
}
