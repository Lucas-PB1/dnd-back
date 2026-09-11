import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_creature_template' })
export class PhbCreatureTemplate {
  @PrimaryColumn({ type: 'text' })
  slug!: string;

  @Column({ name: 'edition_slug', type: 'text' })
  editionSlug!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ name: 'creature_type', type: 'text' })
  creatureType!: string;

  @Column({ name: 'creature_subtype', type: 'text', nullable: true })
  creatureSubtype!: string | null;

  @Column({ name: 'size_slug', type: 'text', nullable: true })
  sizeSlug!: string | null;

  @Column({ name: 'challenge_rating', type: 'text', nullable: true })
  challengeRating!: string | null;

  @Column({ name: 'armor_class', type: 'int', nullable: true })
  armorClass!: number | null;

  @Column({ name: 'hit_points_avg', type: 'int', nullable: true })
  hitPointsAvg!: number | null;

  @Column({ name: 'image_url', type: 'text', nullable: true })
  imageUrl!: string | null;
}
