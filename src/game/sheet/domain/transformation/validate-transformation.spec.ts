import { BadRequestException } from '@nestjs/common';
import {
  assertFeatIsNotTransformationCatalog,
  isGhTransformationFeatSlug,
  validateTransformationShape,
} from './validate-transformation';

describe('validate-transformation', () => {
  it('accepts valid Cap. 6 transformation', () => {
    expect(() =>
      validateTransformationShape({
        slug: 'gh-transformation-vampire',
        stage: 2,
        choices: [{ choiceKind: 'stage1Boon', choiceSlug: 'bloodline-night' }],
      }),
    ).not.toThrow();
  });

  it('rejects non-transformation slug', () => {
    expect(() =>
      validateTransformationShape({
        slug: 'alert',
        stage: 1,
        choices: [],
      }),
    ).toThrow(BadRequestException);
  });

  it('rejects stage outside 1–4', () => {
    expect(() =>
      validateTransformationShape({
        slug: 'gh-transformation-fiend',
        stage: 5,
        choices: [],
      }),
    ).toThrow(/stage/);
  });

  it('rejects duplicate choiceKind', () => {
    expect(() =>
      validateTransformationShape({
        slug: 'gh-transformation-fey',
        stage: 1,
        choices: [
          { choiceKind: 'stage1Boon', choiceSlug: 'a' },
          { choiceKind: 'stage1Boon', choiceSlug: 'b' },
        ],
      }),
    ).toThrow(/Duplicate/);
  });

  it('isGhTransformationFeatSlug / assertFeatIsNotTransformationCatalog', () => {
    expect(isGhTransformationFeatSlug('gh-transformation-lich')).toBe(true);
    expect(isGhTransformationFeatSlug('magic-initiate')).toBe(false);
    expect(() =>
      assertFeatIsNotTransformationCatalog('gh-transformation-specter'),
    ).toThrow(/characterFeats/);
  });
});
