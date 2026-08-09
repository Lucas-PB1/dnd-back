import { FIXTURE_BESTIAL_ASPECT_BENEFITS } from '../__fixtures__/mechanical-catalog.fixtures';
import {
  bestialAspectBenefits,
  carnificinaDamageBonus,
  clampBestialAspectLevel,
} from './beastborne';

describe('beastborne', () => {
  it('clamps bestial aspect level to 0–5', () => {
    expect(clampBestialAspectLevel(0)).toBe(0);
    expect(clampBestialAspectLevel(5)).toBe(5);
    expect(clampBestialAspectLevel(-2)).toBe(0);
    expect(clampBestialAspectLevel(9)).toBe(5);
    expect(clampBestialAspectLevel(3.7)).toBe(3);
    expect(clampBestialAspectLevel(Number.NaN)).toBe(0);
  });

  it('lists cumulative benefits up to level', () => {
    expect(bestialAspectBenefits(FIXTURE_BESTIAL_ASPECT_BENEFITS, 0)).toEqual(
      [],
    );
    expect(
      bestialAspectBenefits(FIXTURE_BESTIAL_ASPECT_BENEFITS, 1),
    ).toHaveLength(1);
    expect(bestialAspectBenefits(FIXTURE_BESTIAL_ASPECT_BENEFITS, 1)[0]).toMatch(
      /Carnificina/,
    );
    expect(
      bestialAspectBenefits(FIXTURE_BESTIAL_ASPECT_BENEFITS, 5),
    ).toHaveLength(5);
    expect(
      bestialAspectBenefits(FIXTURE_BESTIAL_ASPECT_BENEFITS, 99),
    ).toHaveLength(5);
  });

  it('applies Carnificina from aspect level (+2 / +3 at 11)', () => {
    expect(
      carnificinaDamageBonus({
        subclassSlug: 'beastborne',
        characterLevel: 5,
        bestialAspectLevel: 0,
      }),
    ).toBe(0);
    expect(
      carnificinaDamageBonus({
        subclassSlug: 'beastborne',
        characterLevel: 5,
        bestialAspectLevel: 1,
      }),
    ).toBe(2);
    expect(
      carnificinaDamageBonus({
        subclassSlug: 'beastborne',
        characterLevel: 11,
        bestialAspectLevel: 2,
      }),
    ).toBe(3);
    expect(
      carnificinaDamageBonus({
        subclassSlug: 'hunter',
        characterLevel: 11,
        bestialAspectLevel: 5,
      }),
    ).toBe(0);
    expect(
      carnificinaDamageBonus({
        subclassSlug: 'beastborne',
        characterLevel: 2,
        bestialAspectLevel: 3,
      }),
    ).toBe(0);
  });
});
