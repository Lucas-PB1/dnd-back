import { syncTransformation } from './sync-transformation';

describe('syncTransformation', () => {
  let query: jest.Mock;
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    query = jest.fn().mockResolvedValue(undefined);
    dataSource = { query };
  });

  it('clears transformation when null', async () => {
    await syncTransformation(dataSource as never, 'char-1', null);
    expect(query).toHaveBeenCalledTimes(1);
    expect(query.mock.calls[0][0]).toContain('DELETE FROM rpg.player_character_transformation');
    expect(query.mock.calls[0][1]).toEqual(['char-1']);
  });

  it('inserts transformation and choices', async () => {
    await syncTransformation(dataSource as never, 'char-1', {
      slug: 'gh-transformation-vampire',
      stage: 3,
      choices: [
        { choiceKind: 'stage1Boon', choiceSlug: 'bloodline' },
        { choiceKind: 'stage2Boon', choiceSlug: 'charm' },
      ],
    });

    expect(query).toHaveBeenCalledTimes(4);
    expect(query.mock.calls[1][0]).toContain('INSERT INTO rpg.player_character_transformation');
    expect(query.mock.calls[1][1]).toEqual([
      'char-1',
      'gh-transformation-vampire',
      3,
    ]);
    expect(query.mock.calls[2][1]).toEqual(['char-1', 'stage1Boon', 'bloodline']);
    expect(query.mock.calls[3][1]).toEqual(['char-1', 'stage2Boon', 'charm']);
  });
});
