import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import type {
  SkirmishCombatLogEntry,
  SkirmishEndReason,
  SkirmishStatus,
  SkirmishWinnerKind,
} from '../domain/skirmish-status';

@Entity({ schema: 'rpg', name: 'skirmish' })
export class Skirmish {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @Column({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ type: 'text', default: 'active' })
  status!: SkirmishStatus;

  @Column({ type: 'int', default: 1 })
  round!: number;

  @Column({ name: 'turn_attacks_remaining', type: 'int', nullable: true })
  turnAttacksRemaining!: number | null;

  @Column({ name: 'current_combatant_id', type: 'uuid', nullable: true })
  currentCombatantId!: string | null;

  @Column({ name: 'combat_log', type: 'jsonb', default: [] })
  combatLog!: SkirmishCombatLogEntry[];

  @Column({ name: 'winner_kind', type: 'text', nullable: true })
  winnerKind!: SkirmishWinnerKind | null;

  @Column({ name: 'end_reason', type: 'text', nullable: true })
  endReason!: SkirmishEndReason | null;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
