import { pruneMissingActorCombatants } from './sync-allied-actors-into-skirmish';

describe('pruneMissingActorCombatants (PVE-7a despawn)', () => {
  it('removes combatants whose actors were despawned', async () => {
    const deleteCombatant = jest.fn().mockResolvedValue(undefined);
    const repo = {
      listCombatants: jest.fn().mockResolvedValue([
        { id: 'c-pc', kind: 'pc', actorId: null },
        { id: 'c-spirit', kind: 'actor', actorId: 'gone' },
        { id: 'c-foe', kind: 'actor', actorId: 'alive' },
      ]),
      deleteCombatant,
    };
    const actors = {
      findOne: jest.fn().mockImplementation(async ({ where }: { where: { id: string } }) =>
        where.id === 'alive' ? { id: 'alive' } : null,
      ),
    };
    const result = await pruneMissingActorCombatants({
      repo: repo as never,
      actors: actors as never,
      skirmishId: 's1',
      currentCombatantId: 'c-spirit',
    });
    expect(result).toEqual({ removed: 1, currentCleared: true });
    expect(deleteCombatant).toHaveBeenCalledWith('c-spirit');
  });
});
