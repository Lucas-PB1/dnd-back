import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_subclass_precaution_spell' })
export class VPhbSubclassPrecautionSpell {
  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;

  @ViewColumn({ name: 'spell_name' })
  spellName!: string;
}
