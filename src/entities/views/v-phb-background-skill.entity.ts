import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_background_skill' })
export class VPhbBackgroundSkill {
  @ViewColumn({ name: 'background_slug' })
  backgroundSlug!: string;

  @ViewColumn({ name: 'skill_slug' })
  skillSlug!: string;

  @ViewColumn({ name: 'skill_name' })
  skillName!: string;
}
