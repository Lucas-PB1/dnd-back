import {
  classExpertiseSlots,
  classExpertiseSlotsAtLevel,
  classExpertiseSlotsNewAtLevel,
  hasJackOfAllTrades,
  WIZARD_SCHOLAR_SKILL_SLUGS,
} from './class-expertise-slots';

describe('class-expertise-slots', () => {
  it('maps Rogue / Bard / Ranger / Wizard schedules', () => {
    expect(classExpertiseSlotsAtLevel('rogue', 1)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel('rogue', 6)).toHaveLength(4);
    expect(classExpertiseSlotsNewAtLevel('rogue', 6)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel('bard', 2)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel('bard', 9)).toHaveLength(4);
    expect(classExpertiseSlotsNewAtLevel('bard', 9)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel('ranger', 2)).toHaveLength(1);
    expect(classExpertiseSlotsAtLevel('ranger', 9)).toHaveLength(3);
    expect(classExpertiseSlotsNewAtLevel('ranger', 9)).toHaveLength(2);
    expect(classExpertiseSlotsAtLevel('wizard', 2)).toHaveLength(1);
    expect(classExpertiseSlotsNewAtLevel('wizard', 2)).toHaveLength(1);
    expect(classExpertiseSlots('fighter')).toEqual([]);
  });

  it('restricts Wizard scholar skills', () => {
    expect(WIZARD_SCHOLAR_SKILL_SLUGS).toContain('arcana');
    expect(WIZARD_SCHOLAR_SKILL_SLUGS).not.toContain('athletics');
  });

  it('gives Jack of All Trades to Bard 2+', () => {
    expect(hasJackOfAllTrades('bard', 1)).toBe(false);
    expect(hasJackOfAllTrades('bard', 2)).toBe(true);
    expect(hasJackOfAllTrades('rogue', 5)).toBe(false);
  });
});
