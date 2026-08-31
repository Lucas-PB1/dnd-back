import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_heritage_trait_choices' })
export class VPhbHeritageTraitChoices {
  @ViewColumn({ name: 'heritage_slug' })
  heritageSlug!: string;

  @ViewColumn({ name: 'choice_kind' })
  choiceKind!: string;

  @ViewColumn({ name: 'trait_slug' })
  traitSlug!: string;

  @ViewColumn({ name: 'trait_name' })
  traitName!: string;

  @ViewColumn({ name: 'label' })
  label!: string;

  @ViewColumn({ name: 'benefit_base' })
  benefitBase!: string | null;

  @ViewColumn({ name: 'benefit_improved' })
  benefitImproved!: string | null;

  @ViewColumn({ name: 'is_traditional' })
  isTraditional!: boolean;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
