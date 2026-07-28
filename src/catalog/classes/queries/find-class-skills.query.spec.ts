import { FindClassSkillsQuery } from './find-class-skills.query';

describe('FindClassSkillsQuery', () => {
  let skillsRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toClassSkillDto: jest.Mock };
  let query: FindClassSkillsQuery;

  beforeEach(() => {
    skillsRepo = { find: jest.fn().mockResolvedValue([{ skillSlug: 'athletics' }]) };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toClassSkillDto: jest.fn().mockReturnValue({ slug: 'athletics' }) };
    query = new FindClassSkillsQuery(
      skillsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps skill choices', async () => {
    const result = await query.execute('fighter');
    expect(result.data).toEqual([{ slug: 'athletics' }]);
  });

  it('throws when no skill choices', async () => {
    skillsRepo.find.mockResolvedValue([]);
    await expect(query.execute('fighter')).rejects.toThrow(/no skill choices/i);
  });
});
