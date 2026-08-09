import { Repository } from 'typeorm';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { clampHitDiceToLevel } from '../resources/hit-dice';

describe('clampHitDiceToLevel', () => {
  function setup(hitDiceCurrent: number) {
    const state = { hitDiceCurrent } as PlayerCharacterState;
    const stateRepo = {
      save: jest.fn().mockResolvedValue(state),
    } as unknown as Repository<PlayerCharacterState>;
    return { state, stateRepo };
  }

  it('clamps hit dice down to character level and persists', async () => {
    const { state, stateRepo } = setup(8);
    await clampHitDiceToLevel(stateRepo, state, 5);
    expect(state.hitDiceCurrent).toBe(5);
    expect(stateRepo.save).toHaveBeenCalledWith(state);
  });

  it('does nothing when current dice are at or below level', async () => {
    const { state, stateRepo } = setup(3);
    await clampHitDiceToLevel(stateRepo, state, 5);
    expect(state.hitDiceCurrent).toBe(3);
    expect(stateRepo.save).not.toHaveBeenCalled();
  });
});
