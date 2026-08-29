import { ViewColumn, ViewEntity } from 'typeorm';
import type {
  TemplateActionRow,
  TemplateSpeedRow,
  TemplateTraitRow,
} from './v-phb-creature-template-bundle.entity';

@ViewEntity({ schema: 'rpg', name: 'v_phb_vehicle_template_bundle' })
export class VPhbVehicleTemplateBundle {
  @ViewColumn()
  slug!: string;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  subtitle!: string | null;

  @ViewColumn({ name: 'armor_class' })
  armorClass!: number | null;

  @ViewColumn({ name: 'hit_points' })
  hitPoints!: number | null;

  @ViewColumn({ name: 'damage_threshold' })
  damageThreshold!: number | null;

  @ViewColumn({ name: 'crew_capacity' })
  crewCapacity!: number | null;

  @ViewColumn({ name: 'passenger_capacity' })
  passengerCapacity!: number | null;

  @ViewColumn({ name: 'cargo_capacity_lb' })
  cargoCapacityLb!: number | null;

  @ViewColumn({ name: 'cargo_capacity_label' })
  cargoCapacityLabel!: string | null;

  @ViewColumn({ name: 'initiative_modifier' })
  initiativeModifier!: number | null;

  @ViewColumn({ name: 'ability_scores' })
  abilityScores!: Record<string, number> | null;

  @ViewColumn({ name: 'image_url' })
  imageUrl!: string | null;

  @ViewColumn()
  speeds!: TemplateSpeedRow[];

  @ViewColumn()
  actions!: TemplateActionRow[];

  @ViewColumn()
  traits!: TemplateTraitRow[];
}
