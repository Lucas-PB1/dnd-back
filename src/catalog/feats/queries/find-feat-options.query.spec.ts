import { NotFoundException } from '@nestjs/common';
import { FindFeatOptionsQuery } from './find-feat-options.query';

describe('FindFeatOptionsQuery', () => {
  let featRepo: { findOne: jest.Mock };
  let optionDefRepo: { find: jest.Mock };
  let optionValueRepo: { find: jest.Mock };
  let query: FindFeatOptionsQuery;

  beforeEach(() => {
    featRepo = { findOne: jest.fn().mockResolvedValue({ id: 1, slug: 'alert' }) };
    optionDefRepo = {
      find: jest.fn().mockResolvedValue([
        { optionKey: 'skill', valueType: 'catalog', sortOrder: 1 },
      ]),
    };
    optionValueRepo = {
      find: jest.fn().mockResolvedValue([
        { optionKey: 'skill', valueId: 'athletics', label: 'Athletics', sortOrder: 1 },
      ]),
    };
    query = new FindFeatOptionsQuery(
      featRepo as never,
      optionDefRepo as never,
      optionValueRepo as never,
    );
  });

  it('builds options with catalog values', async () => {
    const result = await query.execute('alert');
    expect(result.data[0]).toMatchObject({
      optionKey: 'skill',
      values: [{ valueId: 'athletics' }],
    });
  });

  it('throws when feat missing', async () => {
    featRepo.findOne.mockResolvedValue(null);
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });

  it('omits values for non-catalog option types', async () => {
    optionDefRepo.find.mockResolvedValue([
      { optionKey: 'count', valueType: 'number', sortOrder: 1 },
    ]);
    const result = await query.execute('alert');
    expect(result.data[0].values).toEqual([]);
  });
});
