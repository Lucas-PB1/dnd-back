import { FindSubclassOptionsQuery } from './find-subclass-options.query';

describe('FindSubclassOptionsQuery', () => {
  const optionValuesRepo = {
    manager: {
      query: jest.fn(),
    },
  };
  const subclassRepo = {
    findOne: jest.fn(),
  };
  const catalogLookup = {
    findSubclassOrFail: jest.fn(),
  };

  let query: FindSubclassOptionsQuery;

  beforeEach(() => {
    jest.clearAllMocks();
    query = new FindSubclassOptionsQuery(
      subclassRepo as never,
      optionValuesRepo as never,
      catalogLookup as never,
    );
    subclassRepo.findOne.mockResolvedValue({ id: '1', slug: 'lore' });
  });

  it('returns spell metadata without static values', async () => {
    optionValuesRepo.manager.query
      .mockResolvedValueOnce([
        {
          optionKey: 'magicalDiscovery1',
          optionLabel: 'Descoberta Mágica 1',
          unlockLevel: 6,
          valueType: 'spell',
          spellMaxLevel: 3,
          spellSchoolSlugs: null,
          sortOrder: 4,
        },
      ])
      .mockResolvedValueOnce([]);

    const result = await query.execute('lore', 6);

    expect(result.data[0]).toMatchObject({
      optionKey: 'magicalDiscovery1',
      valueType: 'spell',
      spellMaxLevel: 3,
      values: [],
    });
  });

  it('groups catalog values for fighting style options', async () => {
    optionValuesRepo.manager.query
      .mockResolvedValueOnce([
        {
          optionKey: 'additionalFightingStyle',
          optionLabel: 'Estilo de Luta Adicional',
          unlockLevel: 7,
          valueType: 'fighting_style',
          spellMaxLevel: null,
          spellSchoolSlugs: null,
          sortOrder: 0,
        },
      ])
      .mockResolvedValueOnce([
        {
          optionKey: 'additionalFightingStyle',
          valueId: 'archery',
          valueLabel: 'Arqueria',
          sortOrder: 1,
        },
      ]);

    const result = await query.execute('champion', 7);

    expect(result.data[0].values).toEqual([
      { valueId: 'archery', label: 'Arqueria', sortOrder: 1 },
    ]);
  });
});
