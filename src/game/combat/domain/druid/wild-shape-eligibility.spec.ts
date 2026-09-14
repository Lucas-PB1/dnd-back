import {
  allowsWildShapeFly,
  baseWildShapeTempHp,
  isBeastEligibleForWildShape,
  maxWildShapeCr,
  maxWildShapeKnownForms,
  parseChallengeRating,
  resolveWildShapeBand,
} from './wild-shape-eligibility';

describe('wild-shape-eligibility', () => {
  it('parses challenge ratings', () => {
    expect(parseChallengeRating('0')).toBe(0);
    expect(parseChallengeRating('1/8')).toBe(0.125);
    expect(parseChallengeRating('1/4')).toBe(0.25);
    expect(parseChallengeRating('1/2')).toBe(0.5);
    expect(parseChallengeRating('1')).toBe(1);
    expect(parseChallengeRating(null)).toBeNull();
  });

  it('resolves base CR bands by level', () => {
    expect(resolveWildShapeBand(1)).toBeNull();
    expect(maxWildShapeCr(2)).toBe(0.25);
    expect(maxWildShapeCr(4)).toBe(0.5);
    expect(maxWildShapeCr(8)).toBe(1);
    expect(allowsWildShapeFly(7)).toBe(false);
    expect(allowsWildShapeFly(8)).toBe(true);
  });

  it('resolves known-form capacity by level', () => {
    expect(maxWildShapeKnownForms(1)).toBe(0);
    expect(maxWildShapeKnownForms(2)).toBe(4);
    expect(maxWildShapeKnownForms(4)).toBe(6);
    expect(maxWildShapeKnownForms(8)).toBe(8);
  });

  it('uses floor(level/3) for Moon CR', () => {
    expect(maxWildShapeCr(3, { moon: true })).toBe(1);
    expect(maxWildShapeCr(8, { moon: true })).toBe(2);
    expect(maxWildShapeCr(18, { moon: true })).toBe(6);
  });

  it('accepts CR0 beasts and rejects fly before level 8', () => {
    expect(
      isBeastEligibleForWildShape({
        creatureType: 'Beast',
        challengeRating: '0',
        hasFlySpeed: false,
        level: 2,
      }),
    ).toBe(true);
    expect(
      isBeastEligibleForWildShape({
        creatureType: 'Beast',
        challengeRating: '0',
        hasFlySpeed: true,
        level: 2,
      }),
    ).toBe(false);
    expect(
      isBeastEligibleForWildShape({
        creatureType: 'Beast',
        challengeRating: '0',
        hasFlySpeed: true,
        level: 8,
      }),
    ).toBe(true);
  });

  it('computes base temp HP as druid level', () => {
    expect(baseWildShapeTempHp(5)).toBe(5);
  });
});
