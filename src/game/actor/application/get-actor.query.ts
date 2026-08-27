import { Injectable } from '@nestjs/common';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { ActorResponseDto } from '../dto/actor.dto';

@Injectable()
export class GetActorQuery {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly mapper: ActorMapper,
  ) {}

  async execute(userId: string, id: string): Promise<ActorResponseDto> {
    const row = await this.access.findAccessibleOrFail(userId, id, 'read');
    return this.mapper.toDto(row);
  }
}
