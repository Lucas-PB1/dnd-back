import { ListCharactersQuery } from './list-characters.query';

describe('ListCharactersQuery', () => {
  let repository: { findAllByUser: jest.Mock };
  let mapper: { toSummaryList: jest.Mock };
  let campaigns: { listCampaignRefsByCharacterIds: jest.Mock };
  let query: ListCharactersQuery;

  beforeEach(() => {
    repository = { findAllByUser: jest.fn().mockResolvedValue([{ id: 'a' }]) };
    mapper = {
      toSummaryList: jest.fn().mockReturnValue([
        { id: 'a', name: 'A', campaigns: [] },
        { id: 'b', name: 'B', campaigns: [] },
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

  it('maps summaries and attaches campaign refs', async () => {
    const result = await query.execute('user-1');
    expect(repository.findAllByUser).toHaveBeenCalledWith('user-1');
    expect(mapper.toSummaryList).toHaveBeenCalled();
    expect(campaigns.listCampaignRefsByCharacterIds).toHaveBeenCalledWith([
      'a',
      'b',
    ]);
    expect(result[0].campaigns).toEqual([{ id: 'camp', name: 'C' }]);
    expect(result[1].campaigns).toEqual([]);
  });
});
