import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_subclass_mechanics' })
export class VPhbSubclassMechanics {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;

  @ViewColumn({ name: 'feature_level' })
  featureLevel!: number;

  @ViewColumn({ name: 'feature_name' })
  featureName!: string;

  @ViewColumn({ name: 'feature_kind' })
  featureKind!: string | null;

  @ViewColumn({ name: 'option_key' })
  optionKey!: string | null;

  @ViewColumn({ name: 'resource_slug' })
  resourceSlug!: string | null;

  @ViewColumn({ name: 'resource_name' })
  resourceName!: string | null;

  @ViewColumn({ name: 'resource_unlock_level' })
  resourceUnlockLevel!: number | null;

  @ViewColumn({ name: 'max_formula' })
  maxFormula!: string | null;

  @ViewColumn({ name: 'fixed_max' })
  fixedMax!: number | null;
}
