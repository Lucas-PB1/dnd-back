import { ListCharactersQuery } from './list-characters.query';

describe('ListCharactersQuery', () => {
  let repository: { findAllByUser: jest.Mock };
  let mapper: { toDtoList: jest.Mock };
  let campaigns: { listCampaignRefsByCharacterIds: jest.Mock };
  let query: ListCharactersQuery;

  beforeEach(() => {
    repository = { findAllByUser: jest.fn().mockResolvedValue([{ id: 'a' }]) };
    mapper = {
      toDtoList: jest.fn().mockResolvedValue([
        { id: 'a', name: 'A' },
        { id: 'b', name: 'B' },
      ]),
    };
    campaigns = {
      listCampaignRefsByCharacterIds: jest.fn().mockResolvedValue(
        new Map([['a', [{ id: 'camp', name: 'C' }]]]),
      ),
    };
    query = new ListCharactersQuery(
      repository as never,
      mapper as never,
      campaigns as never,
    );
  });

  it('attaches campaign refs (empty when missing)', async () => {
    const result = await query.execute('user-1');
    expect(repository.findAllByUser).toHaveBeenCalledWith('user-1');
    expect(campaigns.listCampaignRefsByCharacterIds).toHaveBeenCalledWith([
      'a',
      'b',
    ]);
    expect(result[0].campaigns).toEqual([{ id: 'camp', name: 'C' }]);
    expect(result[1].campaigns).toEqual([]);
  });
});
