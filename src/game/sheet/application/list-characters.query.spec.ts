import { ListCharactersQuery } from './list-characters.query';

describe('ListCharactersQuery', () => {
  let repository: { findAllByUser: jest.Mock };
  let mapper: { toSummaryList: jest.Mock };
  let campaigns: { listCampaignRefsByCharacterIds: jest.Mock };
  let dataSource: { query: jest.Mock };
  let query: ListCharactersQuery;

  beforeEach(() => {
    repository = { findAllByUser: jest.fn().mockResolvedValue([{ id: 'a' }]) };
    mapper = {
      toSummaryList: jest.fn().mockReturnValue([
        {
          id: 'a',
          name: 'A',
          classSlug: 'ranger',
          speciesSlug: 'elf',
          subclassSlug: 'fey-wanderer',
          campaigns: [],
        },
        {
          id: 'b',
          name: 'B',
          classSlug: 'fighter',
          speciesSlug: 'dwarf',
          subclassSlug: null,
          campaigns: [],
        },
      ]),
    };
    campaigns = {
      listCampaignRefsByCharacterIds: jest.fn().mockResolvedValue(
        new Map([['a', [{ id: 'camp', name: 'C' }]]]),
      ),
    };
    dataSource = {
      query: jest.fn().mockResolvedValue([
        { kind: 'class', slug: 'ranger', name: 'Patrulheiro' },
        { kind: 'class', slug: 'fighter', name: 'Guerreiro' },
        { kind: 'species', slug: 'elf', name: 'Elfo' },
        { kind: 'species', slug: 'dwarf', name: 'Anão' },
        {
          kind: 'subclass',
          slug: 'fey-wanderer',
          name: 'Andarilho Feérico',
        },
      ]),
    };
    query = new ListCharactersQuery(
      repository as never,
      mapper as never,
      campaigns as never,
      dataSource as never,
    );
  });

  it('maps summaries, catalog names and campaign refs', async () => {
    const result = await query.execute('user-1');
    expect(repository.findAllByUser).toHaveBeenCalledWith('user-1');
    expect(mapper.toSummaryList).toHaveBeenCalled();
    expect(dataSource.query).toHaveBeenCalled();
    expect(campaigns.listCampaignRefsByCharacterIds).toHaveBeenCalledWith([
      'a',
      'b',
    ]);
    expect(result[0]).toMatchObject({
      className: 'Patrulheiro',
      speciesName: 'Elfo',
      subclassName: 'Andarilho Feérico',
      campaigns: [{ id: 'camp', name: 'C' }],
    });
    expect(result[1]).toMatchObject({
      className: 'Guerreiro',
      speciesName: 'Anão',
      subclassName: null,
      campaigns: [],
    });
  });
});
