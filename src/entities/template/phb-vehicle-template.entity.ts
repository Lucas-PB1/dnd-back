import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_vehicle_template' })
export class PhbVehicleTemplate {
  @PrimaryColumn({ type: 'text' })
  slug!: string;

  @Column({ name: 'edition_slug', type: 'text' })
  editionSlug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ name: 'armor_class', type: 'int', nullable: true })
  armorClass!: number | null;

  @Column({ name: 'hit_points', type: 'int', nullable: true })
  hitPoints!: number | null;

  @Column({ name: 'damage_threshold', type: 'int', nullable: true })
  damageThreshold!: number | null;

  @Column({ name: 'crew_capacity', type: 'int', nullable: true })
  crewCapacity!: number | null;

  @Column({ name: 'cargo_capacity_lb', type: 'int', nullable: true })
  cargoCapacityLb!: number | null;

  @Column({ name: 'image_url', type: 'text', nullable: true })
  imageUrl!: string | null;
}
