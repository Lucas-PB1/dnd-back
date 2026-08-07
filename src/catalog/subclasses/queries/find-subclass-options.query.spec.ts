import { NotFoundException } from '@nestjs/common';
import { FindSubclassOptionsQuery } from './find-subclass-options.query';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PhbOptionValue } from '../../../entities/phb-option.entity';
import { PhbSubclassRef } from '../../../entities/phb-subclass-ref.entity';

describe('FindSubclassOptionsQuery', () => {
  let query: FindSubclassOptionsQuery;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findSubclassOrFail'>>;
  let subclassRepo: jest.Mocked<Pick<import('typeorm').Repository<PhbSubclassRef>, 'findOne'>>;
  let optionValuesRepo: {
    findOne: jest.Mock;
    manager: { query: jest.Mock };
  };

  beforeEach(() => {
    catalogLookup = { findSubclassOrFail: jest.fn().mockResolvedValue(undefined) };
    subclassRepo = { findOne: jest.fn() };
    optionValuesRepo = {
      findOne: jest.fn(),
      manager: { query: jest.fn() },
    };
    query = new FindSubclassOptionsQuery(
      subclassRepo as never,
      optionValuesRepo as never,
      catalogLookup as unknown as CatalogLookupService,
    );
  });

  it('groups option values and paginates', async () => {
    subclassRepo.findOne.mockResolvedValue({ id: 'sub-1', slug: 'champion' } as PhbSubclassRef);
    optionValuesRepo.manager.query.mockResolvedValue([
      {
        optionKey: 'fighting_style',
        optionLabel: 'Fighting Style',
        unlockLevel: 3,
        valueType: 'fighting_style',
        valueId: 'defense',
        valueLabel: 'Defense',
        sortOrder: 1,
      },
      {
        optionKey: 'fighting_style',
        optionLabel: 'Fighting Style',
        unlockLevel: 3,
        valueType: 'fighting_style',
        valueId: 'dueling',
        valueLabel: 'Dueling',
        sortOrder: 2,
      },
      {
        optionKey: 'extra_option',
        optionLabel: 'Extra',
        unlockLevel: 7,
        valueType: 'string',
        valueId: 'a',
        valueLabel: 'A',
        sortOrder: 1,
      },
    ]);

    const result = await query.execute('champion', 20, 1, 20);

    expect(catalogLookup.findSubclassOrFail).toHaveBeenCalledWith('champion');
    expect(optionValuesRepo.manager.query).toHaveBeenCalledWith(
      expect.stringContaining('phb_option_def'),
      ['sub-1', 20],
    );
    expect(result.data).toHaveLength(2);
    expect(result.data[0].optionKey).toBe('fighting_style');
    expect(result.data[0].values).toHaveLength(2);
    expect(result.meta).toEqual({ page: 1, limit: 20, total: 2, totalPages: 1 });
  });

  it('throws NotFound when subclass row missing after catalog check', async () => {
    subclassRepo.findOne.mockResolvedValue(null);
    await expect(query.execute('missing')).rejects.toThrow(NotFoundException);
  });

  it('respects character level filter parameter', async () => {
    subclassRepo.findOne.mockResolvedValue({ id: 'sub-1', slug: 'champion' } as PhbSubclassRef);
    optionValuesRepo.manager.query.mockResolvedValue([]);
    await query.execute('champion', 5);
    expect(optionValuesRepo.manager.query).toHaveBeenCalledWith(expect.any(String), ['sub-1', 5]);
  });

  it('paginates grouped options', async () => {
    subclassRepo.findOne.mockResolvedValue({ id: 'sub-1', slug: 'champion' } as PhbSubclassRef);
    optionValuesRepo.manager.query.mockResolvedValue([
      {
        optionKey: 'a',
        optionLabel: 'A',
        unlockLevel: 3,
        valueType: 'string',
        valueId: '1',
        valueLabel: 'One',
        sortOrder: 1,
      },
      {
        optionKey: 'b',
        optionLabel: 'B',
        unlockLevel: 7,
        valueType: 'string',
        valueId: '2',
        valueLabel: 'Two',
        sortOrder: 1,
      },
    ]);

    const result = await query.execute('champion', 20, 2, 1);

    expect(result.data).toHaveLength(1);
    expect(result.data[0].optionKey).toBe('b');
    expect(result.meta).toEqual({ page: 2, limit: 1, total: 2, totalPages: 2 });
  });
});
