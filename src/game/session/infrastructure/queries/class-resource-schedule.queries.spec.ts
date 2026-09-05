import { loadThreadResourceSchedule } from './class-resource-schedule.queries';
import { asDep } from '@common/testing/as-dep';

describe('loadThreadResourceSchedule', () => {
  it('returns empty without characterId', async () => {
    const query = jest.fn();
    await expect(
      loadThreadResourceSchedule(asDep({ query }), ''),
    ).resolves.toEqual([]);
    expect(query).not.toHaveBeenCalled();
  });

  it('maps grant rows for active thread milestones', async () => {
    const query = jest.fn().mockResolvedValue([
      {
        resource_slug: 'jarls-authority',
        resource_name: 'Autoridade do Jarl',
        unlock_level: 1,
        max_formula: 'fixed',
        fixed_max: 1,
        recover_one_on_short: false,
        recover_all_on_short: false,
        recover_all_on_long: true,
        recover_on_long_dice: null,
      },
    ]);

    await expect(
      loadThreadResourceSchedule(asDep({ query }), 'char-1'),
    ).resolves.toEqual([
      {
        resourceSlug: 'jarls-authority',
        resourceName: 'Autoridade do Jarl',
        unlockLevel: 1,
        maxFormula: 'fixed',
        fixedMax: 1,
        recoverOneOnShort: false,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
        recoverOnLongDice: null,
      },
    ]);

    expect(query).toHaveBeenCalledWith(
      expect.stringContaining("e.owner_kind = 'character_thread'"),
      ['char-1', 'cursemarked-greater-sacrifice', expect.any(Array)],
    );
  });
});
