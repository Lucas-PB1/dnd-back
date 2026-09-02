import { loadFeatSlugsByCharacterIds } from './load-feat-slugs-by-character-ids';
import { asDep } from '@common/testing/as-dep';

describe('loadFeatSlugsByCharacterIds', () => {
  it('returns empty map for empty ids', async () => {
    const query = jest.fn();
    await expect(
      loadFeatSlugsByCharacterIds(asDep({ query }), []),
    ).resolves.toEqual(new Map());
    expect(query).not.toHaveBeenCalled();
  });

  it('groups feat slugs by character id', async () => {
    const query = jest.fn().mockResolvedValue([
      { character_id: 'a', feat_slug: 'alert' },
      { character_id: 'a', feat_slug: 'tough' },
      { character_id: 'b', feat_slug: 'lucky' },
    ]);
    const map = await loadFeatSlugsByCharacterIds(asDep({ query }), [
      'a',
      'b',
      'c',
    ]);
    expect(map.get('a')).toEqual(['alert', 'tough']);
    expect(map.get('b')).toEqual(['lucky']);
    expect(map.get('c')).toEqual([]);
  });
});
