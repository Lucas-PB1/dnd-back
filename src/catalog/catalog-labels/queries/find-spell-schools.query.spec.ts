import { FindSpellSchoolsQuery } from './find-spell-schools.query';
import { asDep } from '@common/testing/as-dep';

describe('FindSpellSchoolsQuery', () => {
  it('maps schools ordered by sortOrder', async () => {
    const schools = {
      find: jest.fn().mockResolvedValue([
        { slug: 'abjuracao', name: 'Abjuração', sortOrder: 1 },
      ]),
    };
    const query = new FindSpellSchoolsQuery(asDep(schools));
    await expect(query.execute()).resolves.toEqual([
      { slug: 'abjuracao', name: 'Abjuração', sortOrder: 1 },
    ]);
    expect(schools.find).toHaveBeenCalledWith({
      order: { sortOrder: 'ASC', slug: 'ASC' },
    });
  });
});
