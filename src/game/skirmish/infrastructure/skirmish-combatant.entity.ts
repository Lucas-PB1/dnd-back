import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

export type SkirmishCombatantKind = 'pc' | 'actor';

@Entity({ schema: 'rpg', name: 'skirmish_combatant' })
export class SkirmishCombatant {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'skirmish_id', type: 'uuid' })
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
