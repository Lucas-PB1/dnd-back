import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

export type CampaignRole = 'dm' | 'player' | 'assistant';

@Entity({ schema: 'rpg', name: 'campaign_member' })
export class CampaignMember {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'campaign_id', type: 'uuid' })
  campaignId!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @Column({ type: 'text' })
  role!: CampaignRole;

  @CreateDateColumn({ name: 'joined_at' })
  joinedAt!: Date;
}
