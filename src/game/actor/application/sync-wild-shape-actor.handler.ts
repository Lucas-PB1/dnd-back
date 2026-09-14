import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export type WildShapeActorEnterResult = {
  actorId: string;
};

@Injectable()
export class SyncWildShapeActorHandler {
  constructor(
    private readonly persistence: ActorPersistenceService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
  ) {}

  async enter(input: {
    character: PlayerCharacter;
    ownerUserId: string;
    templateSlug: string;
    templateName: string;
    armorClass: number | null;
    previousActorId: string | null;
  }): Promise<WildShapeActorEnterResult> {
    if (input.previousActorId) {
      await this.removeActor(input.previousActorId);
    }

    const actorId = await this.persistence.spawnFromTemplate({
      templateSlug: input.templateSlug,
      ownerUserId: input.ownerUserId,
      actorKind: 'creature',
      parentCharacterId: input.character.id,
      nameOverride: `Forma: ${input.templateName}`,
    });

    const actor = await this.actors.findOneOrFail({ where: { id: actorId } });
    actor.hitPointsMax = input.character.hitPointsMax;
    actor.hitPointsCurrent = input.character.hitPointsCurrent;
    if (input.armorClass != null) {
      actor.armorClass = input.armorClass;
    }
    await this.actors.save(actor);

    return { actorId };
  }

  async leave(actorId: string | null | undefined): Promise<void> {
    if (!actorId) return;
    await this.removeActor(actorId);
  }

  private async removeActor(actorId: string): Promise<void> {
    const actor = await this.actors.findOne({ where: { id: actorId } });
    if (actor) {
      await this.actors.remove(actor);
    }
  }
}
