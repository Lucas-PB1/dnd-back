import { clampDeathSaveCount, resetDeathSaves } from './death-saves';

describe('death-saves', () => {
  it('clamps values to 0–3', () => {
    expect(clampDeathSaveCount(-1)).toBe(0);
    expect(clampDeathSaveCount(0)).toBe(0);
    expect(clampDeathSaveCount(2)).toBe(2);
    expect(clampDeathSaveCount(3)).toBe(3);
    expect(clampDeathSaveCount(4)).toBe(3);
    expect(clampDeathSaveCount(2.9)).toBe(2);
  });

  it('resets both counters', () => {
    expect(resetDeathSaves()).toEqual({
      deathSaveSuccesses: 0,
      deathSaveFailures: 0,
    });
  });
});
