import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_granted_spell' })
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
