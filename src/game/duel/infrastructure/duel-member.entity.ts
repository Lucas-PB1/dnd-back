import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity({ schema: 'rpg', name: 'duel_member' })
export class DuelMember {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'duel_id', type: 'uuid' })
  duelId!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @Column({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ type: 'boolean', default: false })
  ready!: boolean;

  @Column({ type: 'int', nullable: true })
  initiative!: number | null;

  @Column({ name: 'hit_points_current', type: 'int', nullable: true })
  hitPointsCurrent!: number | null;

  @Column({ name: 'hit_points_max', type: 'int', nullable: true })
  hitPointsMax!: number | null;

  @Column({ name: 'temp_hp', type: 'int', default: 0 })
  tempHp!: number;

  @Column({ type: 'text', array: true, default: '{}' })
  conditions!: string[];

  @Column({ name: 'speed_penalty_m', type: 'int', default: 0 })
  speedPenaltyM!: number;

  @CreateDateColumn({ name: 'joined_at' })
  joinedAt!: Date;
}
