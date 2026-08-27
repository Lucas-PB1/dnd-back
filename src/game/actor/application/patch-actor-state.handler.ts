import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorStateRepository } from '../infrastructure/actor-state.repository';
import { GameActor } from '../infrastructure/game-actor.entity';
import {
  ActorStateResponseDto,
  PatchActorStateDto,
} from '../dto/actor-state.dto';

@Injectable()
export class PatchActorStateHandler {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly state: ActorStateRepository,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
  ) {}

  async execute(
    userId: string,
    actorId: string,
    dto: PatchActorStateDto,
  ): Promise<ActorStateResponseDto> {
    const actor = await this.access.findAccessibleOrFail(
      userId,
      actorId,
      'write',
    );
    return this.state.patch(actor, dto, this.actors);
  }
}
