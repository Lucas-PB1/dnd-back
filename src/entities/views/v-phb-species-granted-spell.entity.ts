import { ViewColumn, ViewEntity } from 'typeorm';

/** Consome MV `mv_phb_species_granted_spell`. */
@ViewEntity({ schema: 'rpg', name: 'mv_phb_species_granted_spell' })
export class VPhbSpeciesGrantedSpell {
  @ViewColumn({ name: 'species_slug' })
  speciesSlug!: string;

  @ViewColumn({ name: 'choice_kind' })
  choiceKind!: string | null;

  @ViewColumn({ name: 'choice_slug' })
  choiceSlug!: string | null;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;
}
