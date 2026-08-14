import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { PhbFightingStyle } from '@entities/phb-fighting-style.entity';
import { FightingStylesMapper } from './fighting-styles.mapper';
import { FindFightingStyleBySlugQuery } from './queries/find-fighting-style-by-slug.query';
import { FindFightingStylesQuery } from './queries/find-fighting-styles.query';

describe('Fighting styles queries', () => {
  let findBySlug: FindFightingStyleBySlugQuery;
  let findAll: FindFightingStylesQuery;
  let repo: jest.Mocked<
    Pick<Repository<PhbFightingStyle>, 'findOne' | 'createQueryBuilder'>
  >;

  const sample: PhbFightingStyle = {
    id: '1',
    slug: 'dueling',
    name: 'Duelismo',
    description: 'Quando empunha uma arma corpo a corpo em uma mão…',
  };

  beforeEach(async () => {
    repo = {
      findOne: jest.fn(),
      createQueryBuilder: jest.fn(),
    };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        FightingStylesMapper,
        FindFightingStyleBySlugQuery,
        FindFightingStylesQuery,
        { provide: getRepositoryToken(PhbFightingStyle), useValue: repo },
      ],
    }).compile();

    findBySlug = module.get(FindFightingStyleBySlugQuery);
    findAll = module.get(FindFightingStylesQuery);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await findBySlug.execute('dueling');
    expect(result).toEqual({
      slug: 'dueling',
      name: 'Duelismo',
      description: sample.description,
    });
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(findBySlug.execute('invalid')).rejects.toThrow(
      NotFoundException,
    );
  });

  it('findAll paginates and maps rows', async () => {
    const qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([sample]),
    };
    repo.createQueryBuilder.mockReturnValue(qb as never);

    const result = await findAll.execute(undefined, 20, 'fighter');
    expect(qb.andWhere).toHaveBeenCalled();
    expect(result.data).toHaveLength(1);
    expect(result.data[0].slug).toBe('dueling');
    expect(result.meta.hasMore).toBe(false);
    expect(result.meta.nextCursor).toBeNull();
  });
});
