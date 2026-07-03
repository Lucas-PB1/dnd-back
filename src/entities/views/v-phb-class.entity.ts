import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class' })
export class VPhbClass {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'class_name' })
  className!: string;

  @ViewColumn({ name: 'primary_ability_label' })
  primaryAbilityLabel!: string | null;

  @ViewColumn({ name: 'primary_ability_operator' })
  primaryAbilityOperator!: string | null;

  @ViewColumn({ name: 'hit_die' })
  hitDie!: string;

  @ViewColumn({ name: 'hp_level1_die_value' })
  hpLevel1DieValue!: number | null;

  @ViewColumn({ name: 'hp_fixed_per_level' })
  hpFixedPerLevel!: number | null;

  @ViewColumn({ name: 'skill_choice_count' })
  skillChoiceCount!: number | null;

  @ViewColumn({ name: 'skill_choice_from' })
  skillChoiceFrom!: string | null;

  @ViewColumn({ name: 'primary_ability_slugs' })
  primaryAbilitySlugs!: string[] | null;

  @ViewColumn({ name: 'source_chapter' })
  sourceChapter!: number | null;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string | null;
}
