import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_character_thread' })
export class PhbCharacterThread {
  @PrimaryColumn({ type: 'text' })
  slug!: string;

  @Column({ name: 'edition_slug', type: 'text' })
  editionSlug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text' })
  summary!: string;

  @Column({ name: 'special_rules_text', type: 'text', nullable: true })
  specialRulesText!: string | null;

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
