import { FindBackgroundEquipmentQuery } from './find-background-equipment.query';
import { asDep } from '@common/testing/as-dep';

describe('FindBackgroundEquipmentQuery', () => {
  let equipmentRepo: { find: jest.Mock };
  let catalogLookup: { findBackgroundOrFail: jest.Mock };
  let mapper: { toEquipmentDto: jest.Mock };
  let query: FindBackgroundEquipmentQuery;

  beforeEach(() => {
    equipmentRepo = {
      find: jest.fn().mockResolvedValue([{ packageSlug: 'a' }]),
    };
    catalogLookup = { findBackgroundOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toEquipmentDto: jest.fn().mockReturnValue({ packageSlug: 'a' }) };
    query = new FindBackgroundEquipmentQuery(
      asDep(equipmentRepo),
      asDep(catalogLookup),
      asDep(mapper),
    );
  });

  it('maps starting equipment', async () => {
    const result = await query.execute('soldier');
    expect(result.data).toEqual([{ packageSlug: 'a' }]);
  });

  it('throws when no equipment', async () => {
    equipmentRepo.find.mockResolvedValue([]);
    await expect(query.execute('soldier')).rejects.toThrow(/no starting equipment/i);
  });
});
