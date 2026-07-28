import { maxSpellLevelFromSlots } from './max-spell-level';

describe('maxSpellLevelFromSlots', () => {
  it('returns 0 without slots', () => {
    expect(maxSpellLevelFromSlots(undefined)).toBe(0);
    expect(maxSpellLevelFromSlots({})).toBe(0);
  });

  it('uses half-caster ranger level 5 (1st + 2nd only)', () => {
    expect(maxSpellLevelFromSlots({ '1': 4, '2': 2 })).toBe(2);
  });

  it('uses full-caster level 5 (up to 3rd)', () => {
    expect(maxSpellLevelFromSlots({ '1': 4, '2': 3, '3': 2 })).toBe(3);
  });

  it('ignores circles with zero slots', () => {
    expect(maxSpellLevelFromSlots({ '1': 4, '2': 0, '3': 0 })).toBe(1);
  });
});
