import { Injectable } from '@nestjs/common';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorRepository } from '../infrastructure/actor.repository';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { UpdateActorDto, ActorResponseDto } from '../dto/actor.dto';
import { clampHitPointsCurrent } from '@game/shared/domain/combat-vitals';

@Injectable()
export class UpdateActorHandler {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly repository: ActorRepository,
    private readonly mapper: ActorMapper,
  ) {}

  async execute(
    userId: string,
    id: string,
    dto: UpdateActorDto,
  ): Promise<ActorResponseDto> {
    const actor = await this.access.findAccessibleOrFail(userId, id, 'write');

    if (dto.name !== undefined) actor.name = dto.name.trim();
    if (dto.hitPointsMax !== undefined) actor.hitPointsMax = dto.hitPointsMax;
    if (dto.hitPointsCurrent !== undefined) {
      actor.hitPointsCurrent = dto.hitPointsCurrent;
    }
    if (dto.armorClass !== undefined) actor.armorClass = dto.armorClass;
    if (dto.initiativeModifier !== undefined) {
      actor.initiativeModifier = dto.initiativeModifier;
    }
    if (dto.notes !== undefined) actor.notes = dto.notes;

    actor.hitPointsCurrent = clampHitPointsCurrent(
      actor.hitPointsCurrent,
      actor.hitPointsMax,
    ) as number | null;

    const saved = await this.repository.save(actor);
    return this.mapper.toDto(saved);
  }
}
