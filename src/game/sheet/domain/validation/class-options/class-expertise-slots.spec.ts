import {
  classExpertiseSlotsAtLevel,
  classExpertiseSlotsNewAtLevel,
  hasJackOfAllTrades,
  isClassExpertiseOptionKey,
} from './class-expertise-slots';
import type { ClassExpertiseSlot } from './class-expertise-slots';

describe('class-expertise-slots', () => {
  const rogue: ClassExpertiseSlot[] = [
    { optionKey: 'expertiseSkill1', unlockLevel: 1 },
    { optionKey: 'expertiseSkill2', unlockLevel: 1 },
    { optionKey: 'expertiseSkill3', unlockLevel: 6 },
    { optionKey: 'expertiseSkill4', unlockLevel: 6 },
  ];
  const bard: ClassExpertiseSlot[] = [
    { optionKey: 'expertiseSkill1', unlockLevel: 2 },
    { optionKey: 'expertiseSkill2', unlockLevel: 2 },
    { optionKey: 'expertiseSkill3', unlockLevel: 9 },
    { optionKey: 'expertiseSkill4', unlockLevel: 9 },
  ];
  const ranger: ClassExpertiseSlot[] = [
    { optionKey: 'expertiseSkill1', unlockLevel: 2 },
    { optionKey: 'expertiseSkill2', unlockLevel: 9 },
    { optionKey: 'expertiseSkill3', unlockLevel: 9 },
  ];
  const wizard: ClassExpertiseSlot[] = [
    { optionKey: 'expertiseSkill1', unlockLevel: 2 },
  ];

  it('filters Rogue / Bard / Ranger / Wizard schedules from catalog slots', () => {
    expect(classExpertiseSlotsAtLevel(rogue, 1)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel(rogue, 6)).toHaveLength(4);
    expect(classExpertiseSlotsNewAtLevel(rogue, 6)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel(bard, 2)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel(bard, 9)).toHaveLength(4);
    expect(classExpertiseSlotsNewAtLevel(bard, 9)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel(ranger, 2)).toHaveLength(1);
    expect(classExpertiseSlotsAtLevel(ranger, 9)).toHaveLength(3);
    expect(classExpertiseSlotsNewAtLevel(ranger, 9)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel(wizard, 2)).toHaveLength(1);
    expect(classExpertiseSlotsNewAtLevel(wizard, 2)).toHaveLength(1);
    expect(classExpertiseSlotsAtLevel([], 20)).toEqual([]);
  });

  it('detects expertise option keys', () => {
    expect(isClassExpertiseOptionKey('expertiseSkill1')).toBe(true);
    expect(isClassExpertiseOptionKey('divineOrder')).toBe(false);
  });

  it('gives Jack of All Trades when level meets catalog unlock', () => {
    expect(hasJackOfAllTrades(2, 1)).toBe(false);
    expect(hasJackOfAllTrades(2, 2)).toBe(true);
    expect(hasJackOfAllTrades(null, 5)).toBe(false);
  });
});
