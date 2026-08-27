import { ViewColumn, ViewEntity } from 'typeorm';

export type TemplateSpeedRow = {
  movementKind: string;
  speedFt: number;
};

export type TemplateActionRow = {
  id: number;
  name: string;
  actionBucket: string;
  attackBonus: number | null;
  damageExpression: string | null;
  reachFt: number | null;
  description: string | null;
  sortOrder: number;
};

export type TemplateSpellRow = {
  spellSlug: string;
  usageKind: string;
  usesPerDay: number | null;
  slotLevel: number | null;
  rechargeDice: string | null;
  sortOrder: number;
};

export type TemplateTraitRow = {
  name: string;
  description: string;
  sortOrder: number;
};

@ViewEntity({ schema: 'rpg', name: 'v_phb_creature_template_bundle' })
export class VPhbCreatureTemplateBundle {
  @ViewColumn()
  slug!: string;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  subtitle!: string | null;

  @ViewColumn()
  alignment!: string | null;

  @ViewColumn({ name: 'initiative_modifier' })
  initiativeModifier!: number | null;

  @ViewColumn({ name: 'ability_scores' })
  abilityScores!: Record<string, number> | null;

  @ViewColumn({ name: 'creature_type' })
  creatureType!: string;

  @ViewColumn({ name: 'creature_subtype' })
  creatureSubtype!: string | null;

  @ViewColumn({ name: 'size_slug' })
  sizeSlug!: string | null;

  @ViewColumn({ name: 'challenge_rating' })
  challengeRating!: string | null;

  @ViewColumn({ name: 'proficiency_bonus' })
  proficiencyBonus!: number | null;

  @ViewColumn({ name: 'armor_class' })
  armorClass!: number | null;

  @ViewColumn({ name: 'hit_points_avg' })
  hitPointsAvg!: number | null;

  @ViewColumn({ name: 'hit_points_formula' })
  hitPointsFormula!: string | null;

  @ViewColumn({ name: 'spellcasting_ability_slug' })
  spellcastingAbilitySlug!: string | null;

  @ViewColumn({ name: 'spell_save_dc' })
  spellSaveDc!: number | null;

  @ViewColumn({ name: 'spell_attack_bonus' })
  spellAttackBonus!: number | null;

  @ViewColumn()
  speeds!: TemplateSpeedRow[];

  @ViewColumn()
  actions!: TemplateActionRow[];

  @ViewColumn()
  spells!: TemplateSpellRow[];

  @ViewColumn()
  traits!: TemplateTraitRow[];
}
