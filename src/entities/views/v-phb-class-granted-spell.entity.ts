import { ViewColumn, ViewEntity } from 'typeorm';

/** Consome MV `mv_phb_class_granted_spell`. */
@ViewEntity({ schema: 'rpg', name: 'mv_phb_class_granted_spell' })
export class VPhbClassGrantedSpell {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;

  @ViewColumn({ name: 'spell_name' })
  spellName!: string;
}
