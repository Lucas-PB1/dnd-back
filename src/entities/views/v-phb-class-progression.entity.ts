import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_progression' })
export class VPhbClassProgression {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'level' })
  level!: number;

  @ViewColumn({ name: 'proficiency_bonus' })
  proficiencyBonus!: number;

  @ViewColumn({ name: 'cantrips' })
  cantrips!: number | null;

  @ViewColumn({ name: 'prepared_spells' })
  preparedSpells!: number | null;

  @ViewColumn({ name: 'channel_divinity' })
  channelDivinity!: number | null;
}
