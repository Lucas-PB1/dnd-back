import { Injectable } from '@nestjs/common';
import { GameActorAccessService } from '../game-actor-access.service';
import { ActorPersistenceService } from '../infrastructure/actor-persistence.service';
import { ActorRepository } from '../infrastructure/actor.repository';
import { ActorMapper } from '../infrastructure/actor.mapper';
import {
  SpawnActorFromTemplateDto,
  ActorResponseDto,
} from '../dto/actor.dto';

@Injectable()
export class SpawnActorFromTemplateHandler {
  constructor(
    private readonly access: GameActorAccessService,
    private readonly persistence: ActorPersistenceService,
    private readonly repository: ActorRepository,
    private readonly mapper: ActorMapper,
  ) {}

  async execute(
    userId: string,
    dto: SpawnActorFromTemplateDto,
  ): Promise<ActorResponseDto> {
    const actorId = await this.persistence.spawnFromTemplate({
      templateSlug: dto.templateSlug,
      ownerUserId: userId,
      actorKind: dto.actorKind,
      campaignId: dto.campaignId ?? null,
      parentCharacterId: dto.parentCharacterId ?? null,
      nameOverride: dto.nameOverride ?? null,
    });
    const actor = await this.repository.findAccessibleOrFail(
      userId,
      actorId,
      'read',
    );
    return this.mapper.toDto(actor);
  }
}
