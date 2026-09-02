import { ViewColumn, ViewEntity } from 'typeorm';

/** Consome MV `mv_phb_feat_granted_spell`. */
@ViewEntity({ schema: 'rpg', name: 'mv_phb_feat_granted_spell' })
export class VPhbFeatGrantedSpell {
  @ViewColumn({ name: 'feat_slug' })
  featSlug!: string;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;
}
