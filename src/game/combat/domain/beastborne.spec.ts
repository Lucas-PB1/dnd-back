import {
  bestialAspectBenefits,
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
    expect(bestialAspectBenefits(0)).toEqual([]);
    expect(bestialAspectBenefits(1)).toHaveLength(1);
    expect(bestialAspectBenefits(1)[0]).toMatch(/Carnificina/);
    expect(bestialAspectBenefits(5)).toHaveLength(5);
    expect(bestialAspectBenefits(99)).toHaveLength(5);
  });
});
