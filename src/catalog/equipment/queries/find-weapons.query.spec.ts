import { FindWeaponsQuery } from './find-weapons.query';
import type { EquipmentMapper } from '../equipment.mapper';
import type { PhbWeapon } from '../../../entities/phb-weapon.entity';

function weaponRow(overrides: Partial<PhbWeapon> = {}): PhbWeapon {
  return {
    category: 'martial',
    damage: '1d8',
    damageType: 'slashing',
    item: {
      slug: 'longsword',
      name: 'Espada Longa',
      cost: 15,
      weight: 3,
      properties: { propertyIds: ['versatile'], versatileDamage: '1d10' },
    },
    ...overrides,
  } as PhbWeapon;
}

describe('FindWeaponsQuery', () => {
  let weaponsRepo: { createQueryBuilder: jest.Mock };
  let propertyRepo: { find: jest.Mock };
  let masteryRepo: { find: jest.Mock };
  let mapper: jest.Mocked<Pick<EquipmentMapper, 'toWeaponDto'>>;
  let query: FindWeaponsQuery;
  let qb: {
    innerJoinAndSelect: jest.Mock;
    orderBy: jest.Mock;
    andWhere: jest.Mock;
    getCount: jest.Mock;
    skip: jest.Mock;
    take: jest.Mock;
    getMany: jest.Mock;
  };

  beforeEach(() => {
    qb = {
      innerJoinAndSelect: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([weaponRow()]),
    };
    weaponsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    propertyRepo = { find: jest.fn().mockResolvedValue([]) };
    masteryRepo = { find: jest.fn().mockResolvedValue([]) };
    mapper = { toWeaponDto: jest.fn().mockReturnValue({ slug: 'longsword' }) };
    query = new FindWeaponsQuery(
      weaponsRepo as never,
      propertyRepo as never,
      masteryRepo as never,
      mapper as never,
    );
  });

  it('builds query, paginates and maps weapons', async () => {
    const result = await query.execute(1, 20, 'sword', 'martial');

    expect(weaponsRepo.createQueryBuilder).toHaveBeenCalledWith('weapon');
    expect(qb.innerJoinAndSelect).toHaveBeenCalledWith('weapon.item', 'item');
    expect(qb.orderBy).toHaveBeenCalledWith('item.name', 'ASC');
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('ILIKE :q'),
      { q: '%sword%' },
    );
    expect(qb.andWhere).toHaveBeenCalledWith('weapon.category = :category', {
      category: 'martial',
    });
    expect(qb.getCount).toHaveBeenCalled();
    expect(qb.getMany).toHaveBeenCalled();
    expect(mapper.toWeaponDto).toHaveBeenCalled();
    expect(result).toEqual({
      data: [{ slug: 'longsword' }],
      meta: { page: 1, limit: 20, total: 1, totalPages: 1 },
    });
  });

  it('skips search and category filters when absent', async () => {
    await query.execute();

    expect(qb.andWhere).not.toHaveBeenCalled();
  });
});
