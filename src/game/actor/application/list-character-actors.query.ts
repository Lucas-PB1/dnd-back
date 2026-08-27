import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { GameActor } from '../infrastructure/game-actor.entity';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { ActorSummaryResponseDto } from '../dto/actor.dto';

@Injectable()
export class ListCharacterActorsQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    private readonly mapper: ActorMapper,
  ) {}

  async execute(
    userId: string,
    characterId: string,
  ): Promise<ActorSummaryResponseDto[]> {
    await this.access.findAccessibleOrFail(userId, characterId, 'read');
    const rows = await this.actors.find({
      where: { parentCharacterId: characterId },
      order: { name: 'ASC', updatedAt: 'DESC' },
    });
    return rows.map((row) => this.mapper.toSummary(row));
  }
}
