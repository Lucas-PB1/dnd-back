import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity({ schema: 'rpg', name: 'campaign' })
export class Campaign {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ type: 'text', nullable: true })
  description!: string | null;

  @Column({ type: 'text',  name: 'invite_code' })
  inviteCode!: string;

  @Column({ name: 'created_by', type: 'uuid' })
  createdBy!: string;

  @Column({
    name: 'allow_player_skip_payment',
    type: 'boolean',
    default: false,
  })
  allowPlayerSkipPayment!: boolean;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
