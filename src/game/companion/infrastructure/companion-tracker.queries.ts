import type { DataSource } from 'typeorm';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { GameActorState } from '@game/actor/infrastructure/game-actor-state.entity';
import {
  toCompanionTracker,
  type CompanionTracker,
} from '../domain/companion-tracker';

export async function loadCompanionTrackers(
  dataSource: DataSource,
  characterId: string,
): Promise<CompanionTracker[]> {
  const actors = await dataSource.getRepository(GameActor).find({
    where: { parentCharacterId: characterId, actorKind: 'companion' },
    order: { name: 'ASC', createdAt: 'ASC' },
  });
  if (actors.length === 0) return [];
  const states = dataSource.getRepository(GameActorState);
  const trackers: CompanionTracker[] = [];
  for (const actor of actors) {
    const state = await states.findOne({ where: { actorId: actor.id } });
    trackers.push(
      toCompanionTracker({
        id: actor.id,
        name: actor.name,
        templateSlug: actor.templateSlug,
        hitPointsCurrent: actor.hitPointsCurrent,
        hitPointsMax: actor.hitPointsMax,
        armorClass: actor.armorClass,
        conditions: state?.conditions ?? [],
      }),
    );
  }
  return trackers;
}
