import { FindSpellsQuery } from './find-spells.query';
import { asDep } from '@common/testing/as-dep';

describe('FindSpellsQuery', () => {
  let spellsRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock; toSummaryDto: jest.Mock };
  let query: FindSpellsQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      select: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ slug: 'fireball', level: 3 }]),
    };
    spellsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = {
      toDto: jest.fn().mockReturnValue({ slug: 'fireball' }),
      toSummaryDto: jest.fn().mockReturnValue({ slug: 'fireball' }),
    };
    query = new FindSpellsQuery(asDep(spellsRepo), asDep(mapper));
  });

  it('filters by level and school', async () => {
    const result = await query.execute({
      q: 'bola',
      level: 3,
      school: 'evocation',
      limit: 20,
    });
    expect(qb.andWhere).toHaveBeenCalledWith('spell.level = :level', {
      level: 3,
    });
    expect(qb.andWhere).toHaveBeenCalledWith('spell.schoolSlug = :schoolSlug', {
      schoolSlug: 'evocation',
    });
    expect(result.data).toEqual([{ slug: 'fireball' }]);
  });

  it('filters by ritual, concentration and roll', async () => {
    await query.execute({
      ritual: true,
      concentration: false,
      roll: 'attack',
    });
    expect(qb.andWhere).toHaveBeenCalledWith('spell.ritual = :ritual', {
      ritual: true,
    });
    expect(qb.andWhere).toHaveBeenCalledWith(
      'spell.concentration = :concentration',
      { concentration: false },
    );
    expect(qb.andWhere).toHaveBeenCalledWith(
      'spell.requiresAttackRoll = true',
    );
  });

  it('filters by casting time, save ability and range kind', async () => {
    await query.execute({
      castingTime: 'bonus',
      saveAbility: 'destreza',
      rangeKind: 'touch',
    });
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('Ação Bônus'),
    );
    expect(qb.andWhere).toHaveBeenCalledWith(
      'spell.saveAbilitySlug = :saveAbility',
      { saveAbility: 'destreza' },
    );
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('Toque'),
    );
  });

  it('skips optional filters when absent', async () => {
    await query.execute();
    expect(qb.andWhere).not.toHaveBeenCalled();
  });
});
