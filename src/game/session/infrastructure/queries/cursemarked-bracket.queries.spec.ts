import { loadActiveCursemarkedBracketBenefit } from './cursemarked-bracket.queries';
import { asDep } from '@common/testing/as-dep';

describe('loadActiveCursemarkedBracketBenefit', () => {
  it('returns null without characterId', async () => {
    const query = jest.fn();
    await expect(
      loadActiveCursemarkedBracketBenefit(asDep({ query }), ''),
    ).resolves.toBeNull();
    expect(query).not.toHaveBeenCalled();
  });

  it('picks highest benefit from milestone rows', async () => {
    const query = jest
      .fn()
      .mockResolvedValueOnce([
        {
          benefit_key: 'tides-of-fate',
          bracket_max_kept: 3,
          bracket_roll_kinds: ['save'],
          bracket_trigger_note: 'Marés',
          milestone_sort: 1,
        },
        {
          benefit_key: 'burdens-shield',
          bracket_max_kept: 5,
          bracket_roll_kinds: ['save', 'skill'],
          bracket_trigger_note: 'Escudo',
          milestone_sort: 2,
        },
      ])
      .mockResolvedValueOnce([
        { benefit_key: 'tides-of-fate' },
        { benefit_key: 'burdens-shield' },
      ]);

    const result = await loadActiveCursemarkedBracketBenefit(
      asDep({ query }),
      'char-1',
    );

    expect(result?.benefitKey).toBe('burdens-shield');
    expect(query).toHaveBeenCalledTimes(2);
  });
});
