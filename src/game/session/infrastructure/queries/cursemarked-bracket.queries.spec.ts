import { loadActiveCursemarkedBracketBenefit } from './cursemarked-bracket.queries';

describe('loadActiveCursemarkedBracketBenefit', () => {
  it('returns null without characterId', async () => {
    const query = jest.fn();
    await expect(
      loadActiveCursemarkedBracketBenefit({ query } as never, ''),
    ).resolves.toBeNull();
    expect(query).not.toHaveBeenCalled();
  });

  it('picks highest benefit from milestone rows', async () => {
    const query = jest.fn().mockResolvedValue([
      { benefit_key: 'tides-of-fate' },
      { benefit_key: 'burdens-shield' },
    ]);

    await expect(
      loadActiveCursemarkedBracketBenefit({ query } as never, 'char-1'),
    ).resolves.toBe('burdens-shield');

    expect(query).toHaveBeenCalledWith(
      expect.stringContaining('player_character_thread'),
      ['char-1', 'cursemarked', expect.any(Array)],
    );
  });
});
