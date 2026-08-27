import { Injectable } from '@nestjs/common';
import { DEFAULT_ABILITY_SCORES } from '@game/shared/domain/ability-scores';
import { ActorRepository } from '../infrastructure/actor.repository';
import { ActorPersistenceService } from '../infrastructure/actor-persistence.service';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { CreateActorDto, ActorResponseDto } from '../dto/actor.dto';

@Injectable()
export class CreateActorHandler {
  constructor(
    private readonly repository: ActorRepository,
    private readonly persistence: ActorPersistenceService,
    private readonly mapper: ActorMapper,
  ) {}

  async execute(userId: string, dto: CreateActorDto): Promise<ActorResponseDto> {
    const actor = this.repository.create({
      ownerUserId: userId,
      campaignId: dto.campaignId ?? null,
      parentCharacterId: dto.parentCharacterId ?? null,
      actorKind: dto.actorKind,
      templateSlug: dto.templateSlug ?? null,
      name: dto.name.trim(),
      hitPointsMax: dto.hitPointsMax ?? null,
      hitPointsCurrent: dto.hitPointsCurrent ?? dto.hitPointsMax ?? null,
      armorClass: dto.armorClass ?? null,
      initiativeModifier: dto.initiativeModifier ?? null,
      proficiencyBonus: dto.proficiencyBonus ?? null,
      abilityScores: DEFAULT_ABILITY_SCORES,
      sizeSlug: dto.sizeSlug ?? null,
      notes: dto.notes ?? null,
    });

    const saved = await this.persistence.createWithChildren(actor, dto);
    return this.mapper.toDto(saved);
  }
}
