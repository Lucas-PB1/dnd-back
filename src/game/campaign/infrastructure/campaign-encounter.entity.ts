import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

export type CampaignEncounterStatus = 'active' | 'closed';
export type CreatureHpVisibility = 'hidden' | 'percent' | 'exact';

@Entity({ schema: 'rpg', name: 'campaign_encounter' })
export class CampaignEncounter {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'campaign_id', type: 'uuid' })
  campaignId!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', default: 'active' })
  status!: CampaignEncounterStatus;

  @Column({ type: 'int', default: 1 })
  round!: number;

  @Column({ name: 'current_turn_index', type: 'int', default: 0 })
  currentTurnIndex!: number;

  @Column({ name: 'players_can_view', type: 'boolean', default: false })
  playersCanView!: boolean;

  @Column({
    name: 'creature_hp_visibility',
    type: 'text',
    default: 'percent',
  })
  creatureHpVisibility!: CreatureHpVisibility;

  @Column({ name: 'created_by', type: 'uuid' })
  createdBy!: string;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
