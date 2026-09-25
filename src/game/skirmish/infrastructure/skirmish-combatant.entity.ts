import { ChildEntity, Column } from 'typeorm';
import { CombatParticipant } from '../../shared/infrastructure/combat-session.entity';

export type SkirmishCombatantKind = 'pc' | 'actor';

@ChildEntity('skirmish')
export class SkirmishCombatant extends CombatParticipant {
  @Column({ name: 'session_id', type: 'uuid' })
  skirmishId!: string;

  @Column({ type: 'text' })
  kind!: SkirmishCombatantKind;

  @Column({ name: 'character_id', type: 'uuid', nullable: true })
  characterId!: string | null;

  @Column({ name: 'actor_id', type: 'uuid', nullable: true })
  actorId!: string | null;

  @Column({ name: 'display_name', type: 'text' })
  displayName!: string;

  @Column({ name: 'initiative_total', type: 'int', nullable: true })
  initiativeTotal!: number | null;

  @Column({ name: 'initiative_modifier', type: 'int', nullable: true })
  initiativeModifier!: number | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive!: boolean;
}
