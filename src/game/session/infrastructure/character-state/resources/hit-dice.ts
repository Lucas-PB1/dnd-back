import { Repository } from 'typeorm';
import { PlayerCharacterState } from '../../player-character-state.entity';

export async function clampHitDiceToLevel(
  stateRepo: Repository<PlayerCharacterState>,
  state: PlayerCharacterState,
  level: number,
): Promise<void> {
  if (state.hitDiceCurrent > level) {
    state.hitDiceCurrent = level;
    await stateRepo.save(state);
  }
}
