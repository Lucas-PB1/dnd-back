import { NotFoundException } from '@nestjs/common';
import { FindBackgroundToolsQuery } from './find-background-tools.query';

describe('FindBackgroundToolsQuery', () => {
  let toolsRepo: { find: jest.Mock };
  let catalogLookup: { findBackgroundOrFail: jest.Mock };
  let mapper: { toToolDto: jest.Mock };
  let query: FindBackgroundToolsQuery;

  beforeEach(() => {
    toolsRepo = { find: jest.fn() };
    catalogLookup = { findBackgroundOrFail: jest.fn() };
    mapper = { toToolDto: jest.fn().mockReturnValue({ slug: 'smiths-tools' }) };
    query = new FindBackgroundToolsQuery(
      toolsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('throws when background has no tool choices', async () => {
    catalogLookup.findBackgroundOrFail.mockResolvedValue({
      toolProficiencyKind: 'fixed',
    });
    await expect(query.execute('soldier')).rejects.toThrow(NotFoundException);
  });

  it('paginates tool options', async () => {
    catalogLookup.findBackgroundOrFail.mockResolvedValue({
      toolProficiencyKind: 'choice',
    });
    toolsRepo.find.mockResolvedValue([{ itemSlug: 'smiths-tools' }]);
    const result = await query.execute('artisan', 1, 50);
    expect(result.data).toEqual([{ slug: 'smiths-tools' }]);
    expect(result.meta.total).toBe(1);
  });

  it('throws when choice background has no configured options', async () => {
    catalogLookup.findBackgroundOrFail.mockResolvedValue({
      toolProficiencyKind: 'choice',
    });
    toolsRepo.find.mockResolvedValue([]);
    await expect(query.execute('artisan')).rejects.toThrow(/no tool options/i);
  });
});
