import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { PhbItem } from '../../entities/phb-item.entity';
import { ItemsMapper } from './items.mapper';
import { FindItemBySlugQuery } from './queries/find-item-by-slug.query';
import { FindItemsQuery } from './queries/find-items.query';

describe('Items queries', () => {
  let findItems: FindItemsQuery;
  let findItemBySlug: FindItemBySlugQuery;
  let repo: jest.Mocked<
    Pick<Repository<PhbItem>, 'findOne' | 'createQueryBuilder'>
  >;

  const sample: PhbItem = {
    id: '1',
    slug: 'longsword',
    name: 'Espada Longa',
    itemType: 'weapon',
    cost: { text: '15 PO' },
    weight: '1,5 kg',
    description: null,
    properties: null,
  };

  beforeEach(async () => {
    const qb = {
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([sample]),
      getManyAndCount: jest.fn().mockResolvedValue([[sample], 1]),
    };
    repo = {
      findOne: jest.fn(),
      createQueryBuilder: jest.fn().mockReturnValue(qb),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ItemsMapper,
        FindItemsQuery,
        FindItemBySlugQuery,
        { provide: getRepositoryToken(PhbItem), useValue: repo },
      ],
    }).compile();

    findItems = module.get(FindItemsQuery);
    findItemBySlug = module.get(FindItemBySlugQuery);
  });

  it('findAll maps rows', async () => {
    const result = await findItems.execute(1, 20);
    expect(result.data[0].name).toBe('Espada Longa');
    expect(result.data[0].costText).toBe('15 PO');
  });

  it('findAll applies search filter', async () => {
    await findItems.execute(1, 20, 'espada');
    const qb = repo.createQueryBuilder.mock.results[0].value;
    expect(qb.andWhere).toHaveBeenCalled();
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await findItemBySlug.execute('longsword');
    expect(result.slug).toBe('longsword');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(findItemBySlug.execute('invalid')).rejects.toThrow(
      NotFoundException,
    );
  });
});
