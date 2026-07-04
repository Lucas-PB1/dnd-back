import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { FindFeatOptionsQuery } from './queries/find-feat-options.query';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../entities/phb-feat-option.entity';

describe('FindFeatOptionsQuery', () => {
  let query: FindFeatOptionsQuery;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        FindFeatOptionsQuery,
        {
          provide: getRepositoryToken(PhbFeatRef),
          useValue: {
            findOne: jest.fn().mockResolvedValue({ id: '1', slug: 'skilled' }),
          },
        },
        {
          provide: getRepositoryToken(PhbFeatOptionDef),
          useValue: {
            find: jest.fn().mockResolvedValue([
              {
                featId: '1',
                optionKey: 'proficiency1',
                label: 'Proficiência 1',
                valueType: 'proficiency',
                sortOrder: 1,
                dependsOnOptionKey: null,
                spellMaxLevel: null,
              },
            ]),
          },
        },
        {
          provide: getRepositoryToken(PhbFeatOptionValue),
          useValue: { find: jest.fn().mockResolvedValue([]) },
        },
      ],
    }).compile();

    query = module.get(FindFeatOptionsQuery);
  });

  it('returns option definitions for a feat', async () => {
    const result = await query.execute('skilled', 1, 20);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].optionKey).toBe('proficiency1');
    expect(result.data[0].valueType).toBe('proficiency');
  });
});
