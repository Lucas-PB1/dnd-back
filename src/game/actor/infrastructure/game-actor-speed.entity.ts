import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'game_actor_speed' })
export class GameActorSpeed {
  @PrimaryColumn({ name: 'actor_id', type: 'uuid' })
  actorId!: string;

  @PrimaryColumn({ name: 'movement_kind', type: 'text' })
  movementKind!: string;

  @Column({ name: 'speed_ft', type: 'int' })
  speedFt!: number;
}
