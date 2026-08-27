import { ViewColumn, ViewEntity } from 'typeorm';

export type CharacterThreadGoalRow = {
  sortOrder: number;
  text: string;
};

export type CharacterThreadBenefitRow = {
  benefitKey: string;
  name: string;
  description: string;
  choiceGroup: string | null;
  sortOrder: number;
};

export type CharacterThreadMilestoneRow = {
  id: number;
  rank: string;
  sortOrder: number;
  benefits: CharacterThreadBenefitRow[];
};

@ViewEntity({ schema: 'rpg', name: 'v_phb_character_thread_bundle' })
export class VPhbCharacterThreadBundle {
  @ViewColumn()
  slug!: string;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  summary!: string;

  @ViewColumn({ name: 'special_rules_text' })
  specialRulesText!: string | null;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;

  @ViewColumn()
  goals!: CharacterThreadGoalRow[];

  @ViewColumn()
  milestones!: CharacterThreadMilestoneRow[];
}
