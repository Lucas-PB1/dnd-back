import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_species_trait_choices' })
export class VPhbSpeciesTraitChoices {
  @ViewColumn({ name: 'species_slug' })
  speciesSlug!: string;

  @ViewColumn({ name: 'trait_name' })
  traitName!: string;

  @ViewColumn({ name: 'choice_kind' })
  choiceKind!: string;

  @ViewColumn({ name: 'choice_slug' })
  choiceSlug!: string;

  @ViewColumn({ name: 'choice_name' })
  choiceName!: string;

  @ViewColumn({ name: 'level1_benefit' })
  level1Benefit!: string | null;

  @ViewColumn({ name: 'spell_level3_slug' })
  spellLevel3Slug!: string | null;

  @ViewColumn({ name: 'spell_level5_slug' })
  spellLevel5Slug!: string | null;

  @ViewColumn({ name: 'damage_type' })
  damageType!: string | null;
}
