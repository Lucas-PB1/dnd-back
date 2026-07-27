import {
  asiFeatLevelsForClass,
  asiFeatLevelsUpTo,
  countAsiFeatSlots,
  isAsiOrFeatLevel,
} from './asi-feat-levels';

describe('asi-feat-levels', () => {
  it('uses the base schedule for most classes', () => {
    expect(asiFeatLevelsForClass('wizard')).toEqual([4, 8, 12, 16, 19]);
    expect(isAsiOrFeatLevel('wizard', 6)).toBe(false);
    expect(countAsiFeatSlots('wizard', 6)).toBe(1);
  });

  it('adds Fighter ASI at 6 and 14', () => {
    expect(asiFeatLevelsForClass('fighter')).toEqual([
      4, 6, 8, 12, 14, 16, 19,
    ]);
    expect(isAsiOrFeatLevel('fighter', 6)).toBe(true);
    expect(isAsiOrFeatLevel('fighter', 14)).toBe(true);
    expect(countAsiFeatSlots('fighter', 6)).toBe(2);
    expect(countAsiFeatSlots('fighter', 14)).toBe(5);
  });

  it('adds Rogue ASI at 10', () => {
    expect(asiFeatLevelsForClass('rogue')).toEqual([4, 8, 10, 12, 16, 19]);
    expect(isAsiOrFeatLevel('rogue', 10)).toBe(true);
    expect(countAsiFeatSlots('rogue', 10)).toBe(3);
    expect(asiFeatLevelsUpTo('rogue', 10)).toEqual([4, 8, 10]);
  });
});
