import {
  asiFeatLevelsUpTo,
  countAsiFeatSlots,
  isAsiOrFeatLevel,
} from './asi-feat-levels';

describe('asi-feat-levels', () => {
  const wizard = [4, 8, 12, 16, 19];
  const fighter = [4, 6, 8, 12, 14, 16, 19];
  const rogue = [4, 8, 10, 12, 16, 19];

  it('compares against catalog levels for a typical class', () => {
    expect(isAsiOrFeatLevel(wizard, 6)).toBe(false);
    expect(isAsiOrFeatLevel(wizard, 4)).toBe(true);
    expect(countAsiFeatSlots(wizard, 6)).toBe(1);
  });

  it('supports fighter extras at 6 and 14', () => {
    expect(isAsiOrFeatLevel(fighter, 6)).toBe(true);
    expect(isAsiOrFeatLevel(fighter, 14)).toBe(true);
    expect(countAsiFeatSlots(fighter, 6)).toBe(2);
    expect(countAsiFeatSlots(fighter, 14)).toBe(5);
  });

  it('supports rogue extra at 10', () => {
    expect(isAsiOrFeatLevel(rogue, 10)).toBe(true);
    expect(countAsiFeatSlots(rogue, 10)).toBe(3);
    expect(asiFeatLevelsUpTo(rogue, 10)).toEqual([4, 8, 10]);
  });
});
