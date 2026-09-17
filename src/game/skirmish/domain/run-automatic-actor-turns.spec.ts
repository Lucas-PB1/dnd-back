import { runAutomaticActorTurns } from './run-automatic-actor-turns';

describe('runAutomaticActorTurns', () => {
  it('resolves the actor turn then advances to the PC', async () => {
    const kinds: Array<'pc' | 'actor'> = ['actor', 'pc'];
    const resolveActorTurn = jest.fn().mockResolvedValue(undefined);
    const advanceTurn = jest.fn().mockImplementation(() => {
      kinds.shift();
    });

    await runAutomaticActorTurns({
      isFinished: () => false,
      currentKind: async () => kinds[0],
      resolveActorTurn,
      advanceTurn,
    });

    expect(resolveActorTurn).toHaveBeenCalledTimes(1);
    expect(advanceTurn).toHaveBeenCalledTimes(1);
  });

  it('does not attack when the current combatant is the PC', async () => {
    const resolveActorTurn = jest.fn();
    const advanceTurn = jest.fn();

    await runAutomaticActorTurns({
      isFinished: () => false,
      currentKind: async () => 'pc',
      resolveActorTurn,
      advanceTurn,
    });

    expect(resolveActorTurn).not.toHaveBeenCalled();
    expect(advanceTurn).not.toHaveBeenCalled();
  });

  it('stops after the actor drop the PC to 0 HP', async () => {
    let finished = false;
    const resolveActorTurn = jest.fn().mockImplementation(() => {
      finished = true;
    });
    const advanceTurn = jest.fn();

    await runAutomaticActorTurns({
      isFinished: () => finished,
      currentKind: async () => 'actor',
      resolveActorTurn,
      advanceTurn,
    });

    expect(resolveActorTurn).toHaveBeenCalledTimes(1);
    expect(advanceTurn).not.toHaveBeenCalled();
  });
});
