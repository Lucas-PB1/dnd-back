import { loadTransformationHitPointsBonus } from './load-transformation-hit-points-bonus';

describe('loadTransformationHitPointsBonus', () => {
  it('returns 0 without transformation', async () => {
    const dataSource = { query: jest.fn() };
    await expect(
      loadTransformationHitPointsBonus(dataSource as never, null, 5),
    ).resolves.toBe(0);
    expect(dataSource.query).not.toHaveBeenCalled();
  });

  it('applies gated bestial-vigor per-level bonus', async () => {
    const dataSource = {
      query: jest.fn().mockResolvedValue([
        {
          flat_bonus: 0,
          per_level_bonus: 1,
          from_level: 1,
          requires_option_key: 'stage3Boon',
          requires_option_value: 'bestial-vigor',
        },
      ]),
    };

    await expect(
      loadTransformationHitPointsBonus(
        dataSource as never,
        {
          slug: 'gh-transformation-lycanthrope',
          choices: [
            { choiceKind: 'stage3Boon', choiceSlug: 'bestial-vigor' },
          ],
        },
        10,
      ),
    ).resolves.toBe(10);

    await expect(
      loadTransformationHitPointsBonus(
        dataSource as never,
        {
          slug: 'gh-transformation-lycanthrope',
          choices: [
            {
              choiceKind: 'stage3Boon',
              choiceSlug: 'shapeshifters-savagery',
            },
          ],
        },
        10,
      ),
    ).resolves.toBe(0);
  });
});
