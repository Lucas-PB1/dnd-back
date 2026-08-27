import { Injectable } from '@nestjs/common';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorRepository } from '../infrastructure/actor.repository';

@Injectable()
export class DeleteActorHandler {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly repository: ActorRepository,
  ) {}

  async execute(userId: string, id: string): Promise<void> {
    const actor = await this.access.findOwnedOrFail(userId, id);
    await this.repository.remove(actor);
  }
}
