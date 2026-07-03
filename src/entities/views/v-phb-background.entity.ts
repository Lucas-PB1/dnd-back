import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_background' })
export class VPhbBackground {
  @ViewColumn({ name: 'background_slug' })
  backgroundSlug!: string;

  @ViewColumn({ name: 'background_name' })
  backgroundName!: string;

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
}
