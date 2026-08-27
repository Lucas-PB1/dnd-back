import { Injectable } from '@nestjs/common';
import { ActorRepository } from './infrastructure/actor.repository';
import { GameActor } from './infrastructure/game-actor.entity';
import type { ActorAccessMode } from './infrastructure/actor.repository';

@Injectable()
export class GameActorAccessService {
  constructor(private readonly actors: ActorRepository) {}

  findOwnedOrFail(userId: string, id: string): Promise<GameActor> {
    return this.actors.findAccessibleOrFail(userId, id, 'own');
  }

  findAccessibleOrFail(
    userId: string,
    id: string,
    mode: ActorAccessMode = 'write',
  ): Promise<GameActor> {
    return this.actors.findAccessibleOrFail(userId, id, mode);
  }
}
