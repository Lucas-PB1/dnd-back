import { loadFeatSlugsByCharacterIds } from './load-feat-slugs-by-character-ids';

describe('loadFeatSlugsByCharacterIds', () => {
  it('returns empty map for empty ids', async () => {
    const query = jest.fn();
    await expect(
      loadFeatSlugsByCharacterIds({ query } as never, []),
    ).resolves.toEqual(new Map());
    expect(query).not.toHaveBeenCalled();
  });

  it('groups feat slugs by character id', async () => {
    const query = jest.fn().mockResolvedValue([
      { character_id: 'a', feat_slug: 'alert' },
      { character_id: 'a', feat_slug: 'tough' },
      { character_id: 'b', feat_slug: 'lucky' },
    ]);
    const map = await loadFeatSlugsByCharacterIds({ query } as never, [
      'a',
      'b',
      'c',
    ]);
    expect(map.get('a')).toEqual(['alert', 'tough']);
    expect(map.get('b')).toEqual(['lucky']);
    expect(map.get('c')).toEqual([]);
  });
});
