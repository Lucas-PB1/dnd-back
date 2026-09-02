import { ViewColumn, ViewEntity } from 'typeorm';

/** Consome MV `mv_class_spell_slots`. */
@ViewEntity({ schema: 'rpg', name: 'mv_class_spell_slots' })
export class VClassSpellSlots {
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

  @ViewColumn({ name: 'channel_divinity' })
  channelDivinity!: number | null;

  @ViewColumn({ name: 'spell_slots' })
  spellSlots!: Record<string, number>;
}
