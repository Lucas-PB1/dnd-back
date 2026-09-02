import { FindBackgroundSkillsQuery } from './find-background-skills.query';
import { asDep } from '@common/testing/as-dep';

describe('FindBackgroundSkillsQuery', () => {
  let skillsRepo: { find: jest.Mock };
  let catalogLookup: { findBackgroundOrFail: jest.Mock };
  let mapper: { toSkillDto: jest.Mock };
  let query: FindBackgroundSkillsQuery;

  beforeEach(() => {
    skillsRepo = { find: jest.fn().mockResolvedValue([{ skillSlug: 'athletics' }]) };
    catalogLookup = { findBackgroundOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toSkillDto: jest.fn().mockReturnValue({ slug: 'athletics' }) };
    query = new FindBackgroundSkillsQuery(
      asDep(skillsRepo),
      asDep(catalogLookup),
      asDep(mapper),
    );
  });

  it('maps fixed skills', async () => {
    const result = await query.execute('soldier');
    expect(result.data).toEqual([{ slug: 'athletics' }]);
  });

  it('throws when no fixed skills', async () => {
    skillsRepo.find.mockResolvedValue([]);
    await expect(query.execute('soldier')).rejects.toThrow(/no fixed skills/i);
  });
});
