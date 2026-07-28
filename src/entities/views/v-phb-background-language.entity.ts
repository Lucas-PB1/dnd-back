import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_background_language' })
export class VPhbBackgroundLanguage {
  @ViewColumn({ name: 'background_slug' })
  backgroundSlug!: string;

  @ViewColumn({ name: 'language_slug' })
  languageSlug!: string;

  @ViewColumn({ name: 'language_name' })
  languageName!: string;

  @ViewColumn({ name: 'language_is_rare' })
  languageIsRare!: boolean;
}
