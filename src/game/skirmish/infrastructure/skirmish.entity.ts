import {
  ChildEntity,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { CombatSession } from '../../shared/infrastructure/combat-session.entity';
import type {
  SkirmishCombatLogEntry,
  SkirmishEndReason,
  SkirmishStatus,
  SkirmishWinnerKind,
} from '../domain/skirmish-status';

@ChildEntity('skirmish')
export class Skirmish extends CombatSession {
  @Column({ name: 'created_by', type: 'uuid' })
  userId!: string;

  @Column({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ type: 'text', default: 'active' })
  status!: SkirmishStatus;

  @Column({ type: 'int', default: 1 })
  round!: number;

  @Column({ name: 'turn_attacks_remaining', type: 'int', nullable: true })
  turnAttacksRemaining!: number | null;

  @Column({ name: 'current_participant_id', type: 'uuid', nullable: true })
  currentCombatantId!: string | null;

  @Column({ name: 'combat_log', type: 'jsonb', default: [] })
  combatLog!: SkirmishCombatLogEntry[];

  @Column({ name: 'arena_effects', type: 'text', array: true, default: [] })
  arenaEffects!: string[];

  @Column({
    name: 'arena_effect_source_character_id',
    type: 'uuid',
    nullable: true,
  })
  arenaEffectSourceCharacterId!: string | null;

  @Column({ name: 'pc_reaction_available', type: 'boolean', default: true })
  pcReactionAvailable!: boolean;

  @Column({ name: 'pc_oa_available', type: 'boolean', default: false })
  pcOaAvailable!: boolean;

  @Column({ name: 'pc_savage_attacker_used', type: 'boolean', default: false })
  pcSavageAttackerUsed!: boolean;

  @Column({ name: 'winner_kind', type: 'text', nullable: true })
  winnerKind!: SkirmishWinnerKind | null;

  @Column({ name: 'end_reason', type: 'text', nullable: true })
  endReason!: SkirmishEndReason | null;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
