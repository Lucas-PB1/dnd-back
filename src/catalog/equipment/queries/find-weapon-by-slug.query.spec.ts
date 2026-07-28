import { NotFoundException } from '@nestjs/common';
import { FindWeaponBySlugQuery } from './find-weapon-by-slug.query';

describe('FindWeaponBySlugQuery', () => {
  let weaponsRepo: { findOne: jest.Mock };
  let propertyRepo: { find: jest.Mock };
  let masteryRepo: { find: jest.Mock };
  let mapper: { toWeaponDto: jest.Mock };
  let query: FindWeaponBySlugQuery;

  beforeEach(() => {
    weaponsRepo = {
      findOne: jest.fn().mockResolvedValue({
        item: { slug: 'longsword', properties: { propertyIds: ['versatile'] } },
      }),
    };
    propertyRepo = { find: jest.fn().mockResolvedValue([{ slug: 'versatile' }]) };
    masteryRepo = { find: jest.fn().mockResolvedValue([]) };
    mapper = { toWeaponDto: jest.fn().mockReturnValue({ slug: 'longsword' }) };
    query = new FindWeaponBySlugQuery(
      weaponsRepo as never,
      propertyRepo as never,
      masteryRepo as never,
      mapper as never,
    );
  });

  it('loads weapon with properties and maps', async () => {
    const result = await query.execute('longsword');
    expect(weaponsRepo.findOne).toHaveBeenCalled();
    expect(propertyRepo.find).toHaveBeenCalled();
    expect(mapper.toWeaponDto).toHaveBeenCalled();
    expect(result).toEqual({ slug: 'longsword' });
  });

  it('throws when missing', async () => {
    weaponsRepo.findOne.mockResolvedValue(null);
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
