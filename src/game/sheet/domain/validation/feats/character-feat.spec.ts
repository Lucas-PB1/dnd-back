import { appendCharacterFeat, nextFeatInstanceIndex } from './character-feat';

describe('character-feat', () => {
  it('computes next instance index', () => {
    const feats = [
      { featSlug: 'magic-initiate', instanceIndex: 0 },
      { featSlug: 'magic-initiate', instanceIndex: 1 },
    ];
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
