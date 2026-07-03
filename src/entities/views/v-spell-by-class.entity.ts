import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_spell_by_class' })
export class VSpellByClass {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'class_name' })
  className!: string;

  @ViewColumn({ name: 'spell_level' })
  spellLevel!: number;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;

  @ViewColumn({ name: 'spell_name' })
  spellName!: string;

  @ViewColumn({ name: 'school_slug' })
  schoolSlug!: string;

  @ViewColumn({ name: 'school_name' })
  schoolName!: string;
}
