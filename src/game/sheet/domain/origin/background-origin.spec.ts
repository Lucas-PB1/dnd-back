import { describe, expect, it } from '@jest/globals';
import {
  mergeGrantedLanguageSlugs,
  resolveBackgroundOriginCharacterFeats,
  resolveBackgroundToolItemSlug,
} from './background-origin';

describe('background-origin', () => {
  it('prepends origin feat when missing', () => {
    expect(
      resolveBackgroundOriginCharacterFeats({ featSlug: 'magic-initiate' }, []),
    ).toEqual([{ featSlug: 'magic-initiate', instanceIndex: 0 }]);
  });

  it('keeps provided feats without duplicating origin', () => {
    expect(
      resolveBackgroundOriginCharacterFeats(
        { featSlug: 'magic-initiate' },
        [
          { featSlug: 'magic-initiate', instanceIndex: 0 },
          { featSlug: 'alert', instanceIndex: 0 },
        ],
      ),
    ).toEqual([
      { featSlug: 'magic-initiate', instanceIndex: 0 },
      { featSlug: 'alert', instanceIndex: 0 },
    ]);
  });

  it('uses fixed tool from background', () => {
    expect(
      resolveBackgroundToolItemSlug(
        { toolProficiencyKind: 'fixed', toolItemSlug: 'ferramentas-de-cartografo' },
        null,
      ),
    ).toBe('ferramentas-de-cartografo');
  });

  it('requires provided slug for choice backgrounds', () => {
    expect(
      resolveBackgroundToolItemSlug(
        { toolProficiencyKind: 'choice', toolItemSlug: null },
        'kit-de-jogos',
      ),
    ).toBe('kit-de-jogos');
  });

  it('prepends granted languages without duplicating player picks', () => {
    expect(mergeGrantedLanguageSlugs(['elvish', 'common'], ['common', 'thieves-cant'])).toEqual([
      'common',
      'thieves-cant',
      'elvish',
    ]);
  });

  it('fills granted languages when the client omits languageSlugs', () => {
    expect(mergeGrantedLanguageSlugs(undefined, ['common'])).toEqual(['common']);
  });
});
