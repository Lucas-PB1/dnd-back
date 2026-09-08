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

  @CreateDateColumn({ name: 'joined_at' })
  joinedAt!: Date;
}
