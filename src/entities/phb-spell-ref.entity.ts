import { Column, Entity, PrimaryColumn } from 'typeorm';

/** Leitura mínima de `phb_spell` para joins (slug + name). */
@Entity({ schema: 'rpg', name: 'phb_spell' })
export class PhbSpellRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text', unique: true })
  slug!: string;

  @Column({ type: 'text' })
  name!: string;
}
