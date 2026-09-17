import { BadRequestException } from '@nestjs/common';
import { spendCombatMetamagic } from './spend-combat-metamagic';

describe('spendCombatMetamagic', () => {
  const character = { id: 'c1', classSlug: 'sorcerer', level: 3 } as never;

  it('rejects metamagic not typed for combat', async () => {
    await expect(
      spendCombatMetamagic({
        dataSource: { query: jest.fn() } as never,
        useClassResource: jest.fn(),
        character,
        metamagicSlug: 'subtle-spell',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends sorcery points for heightened-spell', async () => {
    const useClassResource = jest.fn().mockResolvedValue(undefined);
    const query = jest
      .fn()
      .mockResolvedValueOnce([
        {
          slug: 'heightened-spell',
          name: 'Magia Agravada',
          description: 'desvantagem',
          cost: 2,
          stacks_with_other: false,
        },
      ])
      .mockResolvedValueOnce([]);
    const result = await spendCombatMetamagic({
      dataSource: { query } as never,
      useClassResource,
      character,
      metamagicSlug: 'heightened-spell',
    });
    expect(result.cost).toBe(2);
    expect(result.name).toBe('Magia Agravada');
    expect(useClassResource).toHaveBeenCalledWith(
      character,
      'sorceryPoints',
      2,
    );
  });
});
