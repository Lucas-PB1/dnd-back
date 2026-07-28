import { FindSkillsQuery } from './find-skills.query';

describe('FindSkillsQuery', () => {
  let skillsRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let query: FindSkillsQuery;
  let qb: {
    leftJoinAndSelect: jest.Mock;
    orderBy: jest.Mock;
    andWhere: jest.Mock;
    getCount: jest.Mock;
    skip: jest.Mock;
    take: jest.Mock;
    getMany: jest.Mock;
  };

  beforeEach(() => {
    qb = {
      leftJoinAndSelect: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ slug: 'stealth' }]),
    };
    skillsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toDto: jest.fn().mockReturnValue({ slug: 'stealth' }) };
    query = new FindSkillsQuery(skillsRepo as never, mapper as never);
  });

  it('joins ability, filters and maps', async () => {
    const result = await query.execute(1, 20, 'furt', 'destreza');
    expect(qb.leftJoinAndSelect).toHaveBeenCalledWith('skill.ability', 'ability');
    expect(qb.andWhere).toHaveBeenCalledWith('ability.slug = :abilitySlug', {
      abilitySlug: 'destreza',
    });
    expect(result.data).toEqual([{ slug: 'stealth' }]);
  });

  it('skips ability filter when blank', async () => {
    await query.execute(1, 20, undefined, '  ');
    expect(qb.andWhere).not.toHaveBeenCalledWith(
      'ability.slug = :abilitySlug',
      expect.anything(),
    );
  });
});
