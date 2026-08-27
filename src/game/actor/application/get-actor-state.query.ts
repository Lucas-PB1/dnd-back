import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorStateRepository } from '../infrastructure/actor-state.repository';
import { GameActor } from '../infrastructure/game-actor.entity';
import { ActorStateResponseDto } from '../dto/actor-state.dto';

@Injectable()
export class GetActorStateQuery {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly state: ActorStateRepository,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
  ) {}

  async execute(userId: string, actorId: string): Promise<ActorStateResponseDto> {
    const actor = await this.access.findAccessibleOrFail(userId, actorId, 'read');
    const actorState = await this.state.ensureState(actor.id);
    return this.state.buildResponse(actor, actorState);
  }
}
