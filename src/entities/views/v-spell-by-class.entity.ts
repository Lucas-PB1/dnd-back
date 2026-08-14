import { ViewColumn, ViewEntity } from 'typeorm';

/**
 * Read model de magias por classe.
 * Aponta para a MV (`mv_spell_by_class`) — mesma forma que `v_spell_by_class`,
 * sem recalcular JOINs a cada request. Refresh após seeds.
 */
@ViewEntity({ schema: 'rpg', name: 'mv_spell_by_class' })
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
