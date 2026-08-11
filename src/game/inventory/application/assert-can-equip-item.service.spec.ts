import { BadRequestException } from '@nestjs/common';
import { AssertCanEquipItemService } from './assert-can-equip-item.service';

describe('AssertCanEquipItemService', () => {
  const catalogItems = { findOne: jest.fn() };
  const service = new AssertCanEquipItemService(catalogItems as never);
  const character = { id: 'c1', classSlug: 'fighter' } as never;

  beforeEach(() => {
    catalogItems.findOne.mockReset();
  });

  it('blocks coverage items', async () => {
    catalogItems.findOne.mockResolvedValue({
      slug: 'arma-1-2-ou-3',
      properties: {
        kind: 'coverage',
        appliesTo: 'weapon',
        appliesFilter: 'Qualquer',
        requiresTierBonus: true,
      },
    });
    await expect(service.assert(character, 'arma-1-2-ou-3')).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('allows weapons without proficiency check', async () => {
    catalogItems.findOne.mockResolvedValue({
      slug: 'longsword',
      properties: {},
    });
    await expect(service.assert(character, 'longsword')).resolves.toBeUndefined();
  });
});
