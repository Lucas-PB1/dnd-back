import {
  mysticArcanumSlotsAtLevel,
  mysticArcanumSpellLevelForKey,
} from './mystic-arcanum';

describe('mystic-arcanum', () => {
  it('unlocks one slot per tier', () => {
    expect(mysticArcanumSlotsAtLevel(10)).toEqual([]);
    expect(mysticArcanumSlotsAtLevel(11).map((slot) => slot.optionKey)).toEqual([
      'mysticArcanum6',
    ]);
    expect(mysticArcanumSlotsAtLevel(17).map((slot) => slot.optionKey)).toEqual([
      'mysticArcanum6',
      'mysticArcanum7',
      'mysticArcanum8',
      'mysticArcanum9',
    ]);
    expect(mysticArcanumSpellLevelForKey('mysticArcanum8')).toBe(8);
  });
});
