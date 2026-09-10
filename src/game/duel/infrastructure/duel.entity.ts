import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import type { DuelEndReason, DuelStatus } from '../domain/duel-status';
import type { DuelArenaEffect } from '../domain/arena-effects';

export type DuelCombatLogEntry = {
  at: string;
  text: string;
};

@Entity({ schema: 'rpg', name: 'duel' })
export class Duel {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'text', default: 'open' })
  status!: DuelStatus;

  @Column({ type: 'text', name: 'invite_code' })
  inviteCode!: string;

  @Column({ name: 'created_by', type: 'uuid' })
  createdBy!: string;

  @Column({ name: 'turn_character_id', type: 'uuid', nullable: true })
  turnCharacterId!: string | null;

  @Column({ type: 'int', default: 1 })
  round!: number;

  @Column({ name: 'turn_attacks_remaining', type: 'int', nullable: true })
  turnAttacksRemaining!: number | null;

  @Column({ name: 'combat_log', type: 'jsonb', default: [] })
  combatLog!: DuelCombatLogEntry[];

  @Column({ name: 'arena_effects', type: 'text', array: true, default: '{}' })
  arenaEffects!: DuelArenaEffect[];

  @Column({
    name: 'arena_effect_source_character_id',
    type: 'uuid',
    nullable: true,
  })
  arenaEffectSourceCharacterId!: string | null;

  @Column({ name: 'winner_user_id', type: 'uuid', nullable: true })
  winnerUserId!: string | null;

  @Column({ name: 'winner_character_id', type: 'uuid', nullable: true })
  winnerCharacterId!: string | null;

  @Column({ name: 'end_reason', type: 'text', nullable: true })
  endReason!: DuelEndReason | null;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
