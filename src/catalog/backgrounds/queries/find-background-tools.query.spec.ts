import { NotFoundException } from '@nestjs/common';
import { FindBackgroundToolsQuery } from './find-background-tools.query';
import { asDep } from '@common/testing/as-dep';

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
      asDep(toolsRepo),
      asDep(catalogLookup),
      asDep(mapper),
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
    const result = await query.execute('artisan', undefined, 50);
    expect(result.data).toEqual([{ slug: 'smiths-tools' }]);
    expect(result.meta.hasMore).toBe(false);
    expect(result.meta.nextCursor).toBeNull();
  });

  it('throws when choice background has no configured options', async () => {
    catalogLookup.findBackgroundOrFail.mockResolvedValue({
      toolProficiencyKind: 'choice',
    });
    toolsRepo.find.mockResolvedValue([]);
    await expect(query.execute('artisan')).rejects.toThrow(/no tool options/i);
  });
});
