import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_feat_granted_spell' })
export class VPhbFeatGrantedSpell {
  @ViewColumn({ name: 'feat_slug' })
  featSlug!: string;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;
}
