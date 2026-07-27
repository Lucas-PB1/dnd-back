import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity({ schema: 'rpg', name: 'campaign_character' })
export class CampaignCharacter {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'campaign_id', type: 'uuid' })
  campaignId!: string;

  @Column({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ name: 'linked_by', type: 'uuid' })
  linkedBy!: string;

  @CreateDateColumn({ name: 'linked_at' })
  linkedAt!: Date;
}
