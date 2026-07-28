import { FindSubclassMechanicsQuery } from './find-subclass-mechanics.query';

describe('FindSubclassMechanicsQuery', () => {
  let mechanicsRepo: { find: jest.Mock };
  let catalogLookup: { findSubclassOrFail: jest.Mock };
  let mapper: { toMechanicDto: jest.Mock };
  let query: FindSubclassMechanicsQuery;

  beforeEach(() => {
    mechanicsRepo = { find: jest.fn().mockResolvedValue([{ featureName: 'Sculpt' }]) };
    catalogLookup = { findSubclassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toMechanicDto: jest.fn().mockReturnValue({ name: 'Sculpt' }) };
    query = new FindSubclassMechanicsQuery(
      mechanicsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps subclass mechanics', async () => {
    const result = await query.execute('evoker');
    expect(result.data).toEqual([{ name: 'Sculpt' }]);
  });

  it('throws when no mechanics data', async () => {
    mechanicsRepo.find.mockResolvedValue([]);
    await expect(query.execute('evoker')).rejects.toThrow(/no mechanics data/i);
  });
});
