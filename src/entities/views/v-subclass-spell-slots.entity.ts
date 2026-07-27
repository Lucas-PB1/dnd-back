import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_subclass_spell_slots' })
export class VSubclassSpellSlots {
  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;

  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'class_level' })
  classLevel!: number;

  @ViewColumn({ name: 'pattern_slug' })
  patternSlug!: string;

  @ViewColumn({ name: 'pattern_name' })
  patternName!: string;

  @ViewColumn({ name: 'proficiency_bonus' })
  proficiencyBonus!: number;

  @ViewColumn({ name: 'cantrips' })
  cantrips!: number | null;

  @ViewColumn({ name: 'prepared_spells' })
  preparedSpells!: number | null;

  @ViewColumn({ name: 'spell_list_class_slug' })
  spellListClassSlug!: string;

  @ViewColumn({ name: 'spell_slots' })
  spellSlots!: Record<string, number>;
}
