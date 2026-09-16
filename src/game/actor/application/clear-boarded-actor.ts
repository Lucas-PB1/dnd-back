import type { Repository } from 'typeorm';
import type { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';

export async function clearBoardedIfActor(
  states: Repository<PlayerCharacterState>,
  characterId: string | null | undefined,
  actorId: string,
): Promise<void> {
  if (!characterId) return;
  const state = await states.findOne({ where: { characterId } });
  if (!state || state.boardedActorId !== actorId) return;
  state.boardedActorId = null;
  await states.save(state);
}
