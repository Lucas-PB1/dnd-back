import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorRepository } from '../infrastructure/actor.repository';
import { clearBoardedIfActor } from './clear-boarded-actor';

@Injectable()
export class DeleteActorHandler {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly repository: ActorRepository,
    @InjectRepository(PlayerCharacterState)
    private readonly pcStates: Repository<PlayerCharacterState>,
  ) {}

  async execute(userId: string, id: string): Promise<void> {
    const actor = await this.access.findOwnedOrFail(userId, id);
    await clearBoardedIfActor(this.pcStates, actor.parentCharacterId, actor.id);
    await this.repository.remove(actor);
  }
}
