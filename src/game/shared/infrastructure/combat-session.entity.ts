import { Entity, PrimaryGeneratedColumn, TableInheritance } from 'typeorm';

export type CombatSessionMode = 'encounter' | 'duel' | 'skirmish';

/** Mode-specific columns live on the child entities (Duel, Skirmish, CampaignEncounter). */
@Entity({ schema: 'rpg', name: 'combat_session' })
@TableInheritance({ column: { type: 'text', name: 'mode' } })
export class CombatSession {
  @PrimaryGeneratedColumn('uuid')
  id!: string;
}

/** Mode-specific columns live on the child entities (DuelMember, SkirmishCombatant, CampaignEncounterCombatant). */
@Entity({ schema: 'rpg', name: 'combat_participant' })
@TableInheritance({ column: { type: 'text', name: 'session_mode' } })
export class CombatParticipant {
  @PrimaryGeneratedColumn('uuid')
  id!: string;
}
