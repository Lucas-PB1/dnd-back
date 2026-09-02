import { BadRequestException } from '@nestjs/common';
import { AssertCanBindPactWeaponService } from './assert-can-bind-pact-weapon.service';
import { asDep } from '@common/testing/as-dep';

describe('AssertCanBindPactWeaponService', () => {
  const catalogLookup = { assertItemInCatalog: jest.fn() };
  const options = { count: jest.fn() };
  const service = new AssertCanBindPactWeaponService(
    asDep(catalogLookup),
    asDep(options),
  );
  const warlock = {
    id: 'war-1',
    classSlug: 'warlock',
  };

  beforeEach(() => {
    jest.clearAllMocks();
    options.count.mockResolvedValue(1);
    catalogLookup.assertItemInCatalog.mockResolvedValue({
      itemType: 'weapon',
      properties: { propertyIds: ['versatile'] },
    });
  });

  it('rejects non-warlock characters', async () => {
    await expect(
      service.assert(
        asDep({ ...warlock, classSlug: 'fighter' }),
        'longsword',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects without pact-of-the-blade pick', async () => {
    options.count.mockResolvedValueOnce(0);
    await expect(
      service.assert(asDep(warlock), 'longsword'),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects ranged-only weapons', async () => {
    catalogLookup.assertItemInCatalog.mockResolvedValueOnce({
      itemType: 'weapon',
      properties: { propertyIds: ['ammunition'] },
    });
    await expect(
      service.assert(asDep(warlock), 'longbow'),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('accepts melee weapon for warlock with pact', async () => {
    await expect(
      service.assert(asDep(warlock), 'longsword'),
    ).resolves.toBeUndefined();
  });
});
