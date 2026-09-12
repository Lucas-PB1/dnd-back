import { ViewColumn, ViewEntity } from 'typeorm';

export interface FeatBenefit {
  name?: string;
  description?: string;
}

export interface FeatAbilityPrerequisite {
  abilitySlug: string;
  minimumScore: number;
}

export interface FeatOptionPrerequisite {
  featSlug: string;
  optionKey: string;
  valueId: string;
}

@ViewEntity({ schema: 'rpg', name: 'mv_phb_feat' })
export class VPhbFeat {
  @ViewColumn({ name: 'feat_slug' })
  featSlug!: string;

  @ViewColumn({ name: 'feat_name' })
  featName!: string;

  @ViewColumn({ name: 'category_slug' })
  categorySlug!: string;

  @ViewColumn({ name: 'category_name' })
  categoryName!: string;

  @ViewColumn({ name: 'category_type_label' })
  categoryTypeLabel!: string;

  @ViewColumn({ name: 'repeatable' })
  repeatable!: boolean;

  @ViewColumn({ name: 'prerequisite' })
  prerequisite!: string | null;

  @ViewColumn({ name: 'minimum_level' })
  minimumLevel!: number | null;

  @ViewColumn({ name: 'ability_prerequisites' })
  abilityPrerequisites!: FeatAbilityPrerequisite[];

  @ViewColumn({ name: 'requires_spellcasting' })
  requiresSpellcasting!: boolean;

  @ViewColumn({ name: 'required_armor_training_slug' })
  requiredArmorTrainingSlug!: string | null;

  @ViewColumn({ name: 'requires_fighting_style' })
  requiresFightingStyle!: boolean;

  @ViewColumn({ name: 'requires_weapon_mastery' })
  requiresWeaponMastery!: boolean;

  @ViewColumn({ name: 'required_feat_slugs' })
  requiredFeatSlugs!: string[];

  @ViewColumn({ name: 'required_skill_slugs' })
  requiredSkillSlugs!: string[];

  @ViewColumn({ name: 'required_species_slugs' })
  requiredSpeciesSlugs!: string[];

  @ViewColumn({ name: 'required_weapon_proficiency_slugs' })
  requiredWeaponProficiencySlugs!: string[];

  @ViewColumn({ name: 'required_feat_options' })
  requiredFeatOptions!: FeatOptionPrerequisite[];

  @ViewColumn({ name: 'source_chapter' })
  sourceChapter!: number | null;

  @ViewColumn({ name: 'source_chapter_title' })
  sourceChapterTitle!: string | null;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string | null;

  @ViewColumn({ name: 'benefits' })
  benefits!: FeatBenefit[];
}
