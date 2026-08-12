import {
  PRIMORDIAL_KNOWLEDGE_SKILL_KEY,
  classExtraSkillSlotsAtLevel,
  collectClassExtraSkillSlugs,
  isClassExtraSkillOptionKey,
} from './class-extra-skill-slots';

describe('class-extra-skill-slots', () => {
  it('unlocks barbarian extra skill at level 3', () => {
    expect(classExtraSkillSlotsAtLevel('barbarian', 2)).toEqual([]);
    expect(classExtraSkillSlotsAtLevel('barbarian', 3)).toEqual([
      { optionKey: PRIMORDIAL_KNOWLEDGE_SKILL_KEY, unlockLevel: 3 },
    ]);
    expect(classExtraSkillSlotsAtLevel('fighter', 20)).toEqual([]);
  });

  it('collects primordial knowledge slugs', () => {
    expect(isClassExtraSkillOptionKey(PRIMORDIAL_KNOWLEDGE_SKILL_KEY)).toBe(true);
    expect(
      collectClassExtraSkillSlugs([
        { optionKey: PRIMORDIAL_KNOWLEDGE_SKILL_KEY, valueId: 'survival' },
        { optionKey: 'expertiseSkill1', valueId: 'stealth' },
      ]),
    ).toEqual(['survival']);
  });
});
