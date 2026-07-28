import { FindBackgroundLanguagesQuery } from './find-background-languages.query';

describe('FindBackgroundLanguagesQuery', () => {
  let languagesRepo: { find: jest.Mock };
  let catalogLookup: { findBackgroundOrFail: jest.Mock };
  let mapper: { toLanguageDto: jest.Mock };
  let query: FindBackgroundLanguagesQuery;

  beforeEach(() => {
    languagesRepo = { find: jest.fn() };
    catalogLookup = { findBackgroundOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toLanguageDto: jest.fn().mockReturnValue({ slug: 'common' }) };
    query = new FindBackgroundLanguagesQuery(
      languagesRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps fixed languages', async () => {
    languagesRepo.find.mockResolvedValue([{ languageSlug: 'common' }]);
    const result = await query.execute('soldier');
    expect(catalogLookup.findBackgroundOrFail).toHaveBeenCalledWith('soldier');
    expect(result.data).toEqual([{ slug: 'common' }]);
  });

  it('throws when background has no fixed languages', async () => {
    languagesRepo.find.mockResolvedValue([]);
    await expect(query.execute('acolyte')).rejects.toThrow(/no fixed languages/i);
  });
});
