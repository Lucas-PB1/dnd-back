import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_feature' })
export class VPhbClassFeature {
  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'feature_level' })
  featureLevel!: number;

  @ViewColumn({ name: 'feature_name' })
  featureName!: string;

  @ViewColumn({ name: 'feature_description' })
  featureDescription!: string;
}
