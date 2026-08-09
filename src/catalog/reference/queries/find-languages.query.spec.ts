import { FindLanguagesQuery } from './find-languages.query';
import type { ReferenceMapper } from '../reference.mapper';
import type { PhbLanguage } from '@entities/phb-language.entity';

function languageRow(overrides: Partial<PhbLanguage> = {}): PhbLanguage {
  return {
    slug: 'common',
    name: 'Comum',
    script: 'Comum',
    typicalSpeakers: 'Humanos',
    isRare: false,
    ...overrides,
  } as PhbLanguage;
}

describe('FindLanguagesQuery', () => {
  let languagesRepo: { createQueryBuilder: jest.Mock };
  let mapper: jest.Mocked<Pick<ReferenceMapper, 'toLanguageDto'>>;
  let query: FindLanguagesQuery;
  let qb: {
    orderBy: jest.Mock;
    andWhere: jest.Mock;
    getCount: jest.Mock;
    skip: jest.Mock;
    take: jest.Mock;
    getMany: jest.Mock;
  };

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([languageRow()]),
    };
    languagesRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toLanguageDto: jest.fn().mockReturnValue({ slug: 'common' }) };
    query = new FindLanguagesQuery(languagesRepo as never, mapper as never);
  });

  it('builds query, paginates and maps languages', async () => {
    const result = await query.execute(1, 20, 'comum');

    expect(languagesRepo.createQueryBuilder).toHaveBeenCalledWith('lang');
    expect(qb.orderBy).toHaveBeenCalledWith('lang.name', 'ASC');
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('ILIKE :q'),
      { q: '%comum%' },
    );
    expect(qb.getCount).toHaveBeenCalled();
    expect(qb.getMany).toHaveBeenCalled();
    expect(mapper.toLanguageDto).toHaveBeenCalledWith(languageRow());
    expect(result).toEqual({
      data: [{ slug: 'common' }],
      meta: { page: 1, limit: 20, total: 1, totalPages: 1 },
    });
  });

  it('filters rare languages when rare=true', async () => {
    await query.execute(1, 20, undefined, 'true');
    expect(qb.andWhere).toHaveBeenCalledWith('lang.isRare = true');
  });

  it('filters common languages when rare=false', async () => {
    await query.execute(1, 20, undefined, 'false');
    expect(qb.andWhere).toHaveBeenCalledWith('lang.isRare = false');
  });
});
