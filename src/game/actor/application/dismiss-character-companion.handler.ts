import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { GameActor } from '../infrastructure/game-actor.entity';
import { clearBoardedIfActor } from './clear-boarded-actor';
import { DismissCharacterCompanionDto } from '../dto/character-companion.dto';

@Injectable()
export class DismissCharacterCompanionHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(PlayerCharacterState)
    private readonly pcStates: Repository<PlayerCharacterState>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: DismissCharacterCompanionDto = {},
  ): Promise<{ dismissedActorId: string }> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const linked = await this.actors.find({
      where: { parentCharacterId: characterId, actorKind: 'companion' },
      order: { createdAt: 'ASC' },
    });
    if (linked.length === 0) {
      throw new BadRequestException('Nenhum companheiro vinculado a este personagem');
    }
    const actor = dto.actorId
      ? linked.find((row) => row.id === dto.actorId)
      : linked.length === 1
        ? linked[0]
        : null;
    if (dto.actorId && !actor) {
      throw new NotFoundException(`Companion actor '${dto.actorId}' not found`);
    }
    if (!actor) {
      throw new BadRequestException(
        'Há mais de um companheiro; informe actorId para dispensar',
      );
    }
    await clearBoardedIfActor(this.pcStates, characterId, actor.id);
    await this.actors.remove(actor);
    return { dismissedActorId: actor.id };
  }
}
