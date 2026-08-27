import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

export type ActorActionBucket =
  | 'action'
  | 'bonus'
  | 'reaction'
  | 'legendary'
  | 'other';

@Entity({ schema: 'rpg', name: 'game_actor_action' })
export class GameActorAction {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'actor_id', type: 'uuid' })
  actorId!: string;

  @Column({ type: 'text' })
  name!: string;

  @Column({ name: 'action_bucket', type: 'text', default: 'action' })
  actionBucket!: ActorActionBucket;

  @Column({ name: 'attack_bonus', type: 'int', nullable: true })
  attackBonus!: number | null;

  @Column({ name: 'damage_expression', type: 'text', nullable: true })
  damageExpression!: string | null;

  @Column({ name: 'reach_ft', type: 'int', nullable: true })
  reachFt!: number | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;
}
