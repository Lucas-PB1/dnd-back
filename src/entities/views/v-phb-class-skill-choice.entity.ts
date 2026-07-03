import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_skill_choice' })
export class VPhbClassSkillChoice {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'skill_choice_count' })
  skillChoiceCount!: number | null;

  @ViewColumn({ name: 'skill_choice_from' })
  skillChoiceFrom!: string | null;

  @ViewColumn({ name: 'skill_slug' })
  skillSlug!: string;

  @ViewColumn({ name: 'skill_name' })
  skillName!: string;
}
