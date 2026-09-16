import type { DataSource } from 'typeorm';
import { GameActor } from '../infrastructure/game-actor.entity';
import { GameActorState } from '../infrastructure/game-actor-state.entity';
import { clearMountLongRestUses } from '../domain/mount-sheet';

export async function resetLinkedMountLongRestUses(
  dataSource: DataSource,
  characterId: string,
): Promise<void> {
  const actors = await dataSource.getRepository(GameActor).find({
    where: { parentCharacterId: characterId, actorKind: 'mount' },
  });
  if (actors.length === 0) return;
  const states = dataSource.getRepository(GameActorState);
  for (const actor of actors) {
    const state = await states.findOne({ where: { actorId: actor.id } });
    if (!state) continue;
    const next = clearMountLongRestUses(state.innateSpellUses);
    state.innateSpellUses = next;
    await states.save(state);
  }
}
