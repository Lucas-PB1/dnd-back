import {
  appendCharacterFeat,
  characterFeatsFromSlugs,
  nextFeatInstanceIndex,
} from './character-feat';

describe('character-feat', () => {
  it('indexes repeated slugs in order', () => {
    expect(characterFeatsFromSlugs(['magic-initiate', 'alert', 'magic-initiate'])).toEqual([
      { featSlug: 'magic-initiate', instanceIndex: 0 },
      { featSlug: 'alert', instanceIndex: 0 },
      { featSlug: 'magic-initiate', instanceIndex: 1 },
    ]);
  });

  it('computes next instance index', () => {
    const feats = characterFeatsFromSlugs(['magic-initiate', 'magic-initiate']);
    expect(nextFeatInstanceIndex(feats, 'magic-initiate')).toBe(2);
    expect(nextFeatInstanceIndex(feats, 'alert')).toBe(0);
  });

  it('appends a new feat instance', () => {
    const feats = [{ featSlug: 'magic-initiate', instanceIndex: 0 }];
    expect(appendCharacterFeat(feats, 'magic-initiate')).toEqual([
      { featSlug: 'magic-initiate', instanceIndex: 0 },
      { featSlug: 'magic-initiate', instanceIndex: 1 },
    ]);
  });
});
