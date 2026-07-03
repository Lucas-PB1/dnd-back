import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_class_spell_slots' })
export class VClassSpellSlots {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'class_level' })
  classLevel!: number;

  @ViewColumn({ name: 'pattern_slug' })
  patternSlug!: string;

  @ViewColumn({ name: 'pattern_name' })
  patternName!: string;

  @ViewColumn({ name: 'spell_slots' })
  spellSlots!: Record<string, number>;
}
