import { ChildEntity, Column } from 'typeorm';
import { CombatParticipant } from '../../shared/infrastructure/combat-session.entity';

export type EncounterCombatantKind = 'pc' | 'actor';

@ChildEntity('encounter')
export class CampaignEncounterCombatant extends CombatParticipant {
  @Column({ name: 'session_id', type: 'uuid' })
  encounterId!: string;

  @Column({ type: 'text', default: 'pc' })
  kind!: EncounterCombatantKind;

  @Column({ name: 'character_id', type: 'uuid', nullable: true })
  characterId!: string | null;

  @Column({ name: 'actor_id', type: 'uuid', nullable: true })
  actorId!: string | null;

  @Column({ name: 'initiative_total', type: 'int', nullable: true })
  initiativeTotal!: number | null;

  @Column({ name: 'initiative_modifier', type: 'int', nullable: true })
  initiativeModifier!: number | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive!: boolean;

  @Column({ name: 'hit_points_current', type: 'int', nullable: true })
  hitPointsCurrent!: number | null;

  @Column({ name: 'hit_points_max', type: 'int', nullable: true })
  hitPointsMax!: number | null;

  @Column({ name: 'temp_hp', type: 'int', default: 0 })
  tempHp!: number;

  @Column({ type: 'text', array: true, default: '{}' })
  conditions!: string[];
}
