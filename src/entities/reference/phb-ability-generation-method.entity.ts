import { ViewEntity, ViewColumn } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_ability_generation_method' })
export class PhbAbilityGenerationMethod {
  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  description!: string;
}
