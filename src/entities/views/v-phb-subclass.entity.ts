import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_subclass' })
export class VPhbSubclass {
  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;

  @ViewColumn({ name: 'subclass_name' })
  subclassName!: string;

  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'class_name' })
  className!: string;

  @ViewColumn({ name: 'tagline' })
  tagline!: string | null;

  @ViewColumn({ name: 'summary' })
  summary!: string | null;

  @ViewColumn({ name: 'source_chapter' })
  sourceChapter!: number | null;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string | null;

  @ViewColumn({ name: 'spell_source_slug' })
  spellSourceSlug!: string | null;

  @ViewColumn({ name: 'spell_source_label' })
  spellSourceLabel!: string | null;
}
