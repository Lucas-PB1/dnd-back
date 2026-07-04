import { describe, expect, it } from '@jest/globals';
import {
  resolveBackgroundOriginFeatSlugs,
  resolveBackgroundToolItemSlug,
} from './background-origin';

describe('background-origin', () => {
  it('prepends origin feat when missing', () => {
    expect(
      resolveBackgroundOriginFeatSlugs({ featSlug: 'magic-initiate' }, []),
    ).toEqual(['magic-initiate']);
  });

  it('keeps provided feat slugs without duplicating origin', () => {
    expect(
      resolveBackgroundOriginFeatSlugs(
        { featSlug: 'magic-initiate' },
        ['magic-initiate', 'alert'],
      ),
    ).toEqual(['magic-initiate', 'alert']);
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
});
