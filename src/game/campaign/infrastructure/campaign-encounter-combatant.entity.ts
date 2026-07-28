import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

export type EncounterCombatantKind = 'pc' | 'creature';

@Entity({ schema: 'rpg', name: 'campaign_encounter_combatant' })
export class CampaignEncounterCombatant {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'encounter_id', type: 'uuid' })
  encounterId!: string;

  @Column({ type: 'text', default: 'pc' })
  kind!: EncounterCombatantKind;

  @Column({ name: 'character_id', type: 'uuid', nullable: true })
  characterId!: string | null;

  @Column({ name: 'display_name', type: 'text', nullable: true })
  displayName!: string | null;

  @Column({ name: 'hp_current', type: 'int', nullable: true })
  hpCurrent!: number | null;

  @Column({ name: 'hp_max', type: 'int', nullable: true })
  hpMax!: number | null;

  @Column({ name: 'armor_class', type: 'int', nullable: true })
  armorClass!: number | null;

  @Column({ name: 'initiative_total', type: 'int', nullable: true })
  initiativeTotal!: number | null;

  @Column({ name: 'initiative_modifier', type: 'int', nullable: true })
  initiativeModifier!: number | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive!: boolean;
}
