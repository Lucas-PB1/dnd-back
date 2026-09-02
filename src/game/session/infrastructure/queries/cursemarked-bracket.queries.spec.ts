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
    const query = jest.fn().mockResolvedValue([
      { benefit_key: 'tides-of-fate' },
      { benefit_key: 'burdens-shield' },
    ]);

    await expect(
      loadActiveCursemarkedBracketBenefit(asDep({ query }), 'char-1'),
    ).resolves.toBe('burdens-shield');

    expect(query).toHaveBeenCalledWith(
      expect.stringContaining('player_character_thread'),
      ['char-1', 'cursemarked', expect.any(Array)],
    );
  });
});
