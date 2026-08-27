import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import type { AbilityScores } from '@game/shared/domain/ability-scores';

export type ActorKind = 'creature' | 'mount' | 'vehicle' | 'companion';

@Entity({ schema: 'rpg', name: 'game_actor' })
export class GameActor {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'owner_user_id', type: 'uuid' })
  ownerUserId!: string;

  @Column({ name: 'campaign_id', type: 'uuid', nullable: true })
  campaignId!: string | null;

  @Column({ name: 'parent_character_id', type: 'uuid', nullable: true })
  parentCharacterId!: string | null;

  @Column({ name: 'actor_kind', type: 'text' })
  actorKind!: ActorKind;

  @Column({ name: 'template_slug', type: 'text', nullable: true })
  templateSlug!: string | null;

  @Column({ type: 'text' })
  name!: string;

  @Column({ name: 'hit_points_max', type: 'int', nullable: true })
  hitPointsMax!: number | null;

  @Column({ name: 'hit_points_current', type: 'int', nullable: true })
  hitPointsCurrent!: number | null;

  @Column({ name: 'armor_class', type: 'int', nullable: true })
  armorClass!: number | null;

  @Column({ name: 'initiative_modifier', type: 'int', nullable: true })
  initiativeModifier!: number | null;

  @Column({ name: 'proficiency_bonus', type: 'int', nullable: true })
  proficiencyBonus!: number | null;

  @Column({ name: 'ability_scores', type: 'jsonb' })
  abilityScores!: AbilityScores;

  @Column({ name: 'size_slug', type: 'text', nullable: true })
  sizeSlug!: string | null;

  @Column({ type: 'text', nullable: true })
  notes!: string | null;

  @Column({ name: 'spellcasting_ability_slug', type: 'text', nullable: true })
  spellcastingAbilitySlug!: string | null;

  @Column({ name: 'spell_save_dc', type: 'int', nullable: true })
  spellSaveDc!: number | null;

  @Column({ name: 'spell_attack_bonus', type: 'int', nullable: true })
  spellAttackBonus!: number | null;

  @Column({ name: 'damage_threshold', type: 'int', nullable: true })
  damageThreshold!: number | null;

  @Column({ name: 'crew_capacity', type: 'int', nullable: true })
  crewCapacity!: number | null;

  @Column({ name: 'passenger_capacity', type: 'int', nullable: true })
  passengerCapacity!: number | null;

  @Column({ name: 'cargo_capacity_lb', type: 'int', nullable: true })
  cargoCapacityLb!: number | null;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
