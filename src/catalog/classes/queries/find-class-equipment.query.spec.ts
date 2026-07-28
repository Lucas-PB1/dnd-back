import { FindClassEquipmentQuery } from './find-class-equipment.query';

describe('FindClassEquipmentQuery', () => {
  let equipmentRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toEquipmentDto: jest.Mock };
  let query: FindClassEquipmentQuery;

  beforeEach(() => {
    equipmentRepo = {
      find: jest.fn().mockResolvedValue([{ packageSlug: 'a' }]),
    };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toEquipmentDto: jest.fn().mockReturnValue({ packageSlug: 'a' }) };
    query = new FindClassEquipmentQuery(
      equipmentRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps class starting equipment', async () => {
    const result = await query.execute('fighter');
    expect(result.data).toEqual([{ packageSlug: 'a' }]);
  });

  it('throws when class has no equipment', async () => {
    equipmentRepo.find.mockResolvedValue([]);
    await expect(query.execute('fighter')).rejects.toThrow(/no starting equipment/i);
  });
});
