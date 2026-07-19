import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_background' })
export class VPhbBackground {
  @ViewColumn({ name: 'background_slug' })
  backgroundSlug!: string;

  @ViewColumn({ name: 'background_name' })
  backgroundName!: string;

  @ViewColumn({ name: 'tagline' })
  tagline!: string | null;

  @ViewColumn({ name: 'summary' })
  summary!: string | null;

  @ViewColumn({ name: 'description' })
  description!: string | null;

  @ViewColumn({ name: 'equipment_gold_option' })
  equipmentGoldOption!: number | null;

  @ViewColumn({ name: 'source_chapter' })
  sourceChapter!: number | null;

  @ViewColumn({ name: 'source_chapter_title' })
  sourceChapterTitle!: string | null;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string | null;

  @ViewColumn({ name: 'ability_option_slugs' })
  abilityOptionSlugs!: string[] | null;

  @ViewColumn({ name: 'ability_option_names' })
  abilityOptionNames!: string[] | null;

  @ViewColumn({ name: 'feat_slug' })
  featSlug!: string | null;

  @ViewColumn({ name: 'feat_name' })
  featName!: string | null;

  @ViewColumn({ name: 'tool_proficiency_kind' })
  toolProficiencyKind!: string | null;

  @ViewColumn({ name: 'tool_proficiency_description' })
  toolProficiencyDescription!: string | null;

  @ViewColumn({ name: 'tool_item_slug' })
  toolItemSlug!: string | null;

  @ViewColumn({ name: 'tool_item_name' })
  toolItemName!: string | null;

  @ViewColumn({ name: 'tool_category_slug' })
  toolCategorySlug!: string | null;

  @ViewColumn({ name: 'tool_category_name' })
  toolCategoryName!: string | null;
}
