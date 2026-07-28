import { ClassProficienciesQuery } from './class-proficiencies.query';

describe('ClassProficienciesQuery', () => {
  let dataSource: { query: jest.Mock };
  let query: ClassProficienciesQuery;

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    query = new ClassProficienciesQuery(dataSource as never);
  });

  it('returns empty profile when all queries empty', async () => {
    dataSource.query.mockResolvedValue([]);
    await expect(query.forClassSlug('unknown')).resolves.toEqual({
      savingThrowSlugs: [],
      savingThrowNames: [],
      armorTrainingSlugs: [],
      armorTrainingNames: [],
      weaponProficiencySlugs: [],
      weaponProficiencyNames: [],
      fightingStyleSlugs: [],
      fightingStyleNames: [],
    });
  });

  it('maps saving throws, armor, weapons and fighting styles', async () => {
    dataSource.query
      .mockResolvedValueOnce([{ slug: 'forca', name: 'Força' }])
      .mockResolvedValueOnce([{ slug: 'light', name: 'Leve' }])
      .mockResolvedValueOnce([{ slug: 'simple', label: 'Simples' }])
      .mockResolvedValueOnce([{ slug: 'archery', name: 'Arquearia' }]);

    await expect(query.forClassSlug('fighter')).resolves.toEqual({
      savingThrowSlugs: ['forca'],
      savingThrowNames: ['Força'],
      armorTrainingSlugs: ['light'],
      armorTrainingNames: ['Leve'],
      weaponProficiencySlugs: ['simple'],
      weaponProficiencyNames: ['Simples'],
      fightingStyleSlugs: ['archery'],
      fightingStyleNames: ['Arquearia'],
    });
    expect(dataSource.query).toHaveBeenCalledTimes(4);
  });
});
