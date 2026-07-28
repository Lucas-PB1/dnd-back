import {
  classWeaponMasterySlotsAtLevel,
  classWeaponMasterySlotsFromProgression,
  classWeaponMasterySlotsNewAtLevel,
  collectMasteredWeaponSlugs,
} from './class-weapon-mastery-slots';

const fighterProgression = [
  { level: 1, weaponMastery: 3 },
  { level: 3, weaponMastery: 3 },
  { level: 4, weaponMastery: 4 },
  { level: 9, weaponMastery: 4 },
  { level: 10, weaponMastery: 5 },
  { level: 15, weaponMastery: 5 },
  { level: 16, weaponMastery: 6 },
  { level: 20, weaponMastery: 6 },
];

const barbarianProgression = [
  { level: 1, weaponMastery: 2 },
  { level: 3, weaponMastery: 2 },
  { level: 4, weaponMastery: 3 },
  { level: 9, weaponMastery: 3 },
  { level: 10, weaponMastery: 4 },
  { level: 20, weaponMastery: 4 },
];

describe('class-weapon-mastery-slots', () => {
  it('derives Fighter slots from progression counts', () => {
    expect(classWeaponMasterySlotsFromProgression(fighterProgression)).toEqual([
      { optionKey: 'masteryWeapon1', unlockLevel: 1 },
      { optionKey: 'masteryWeapon2', unlockLevel: 1 },
      { optionKey: 'masteryWeapon3', unlockLevel: 1 },
      { optionKey: 'masteryWeapon4', unlockLevel: 4 },
      { optionKey: 'masteryWeapon5', unlockLevel: 10 },
      { optionKey: 'masteryWeapon6', unlockLevel: 16 },
    ]);
    expect(classWeaponMasterySlotsAtLevel(fighterProgression, 1)).toHaveLength(3);
    expect(classWeaponMasterySlotsNewAtLevel(fighterProgression, 4)).toHaveLength(
      1,
    );
  });

  it('derives Barbarian slots from progression counts', () => {
    expect(classWeaponMasterySlotsAtLevel(barbarianProgression, 4)).toHaveLength(
      3,
    );
    expect(
      classWeaponMasterySlotsNewAtLevel(barbarianProgression, 10),
    ).toHaveLength(1);
  });

  it('returns empty when progression has no mastery column', () => {
    expect(
      classWeaponMasterySlotsFromProgression([
        { level: 1, weaponMastery: null },
        { level: 5, weaponMastery: null },
      ]),
    ).toEqual([]);
  });

  it('collects mastered weapons from class and feat options', () => {
    expect(
      collectMasteredWeaponSlugs({
        classOptions: [
          { optionKey: 'masteryWeapon1', valueId: 'longsword' },
          { optionKey: 'expertiseSkill1', valueId: 'stealth' },
        ],
        featOptions: [{ optionKey: 'masteryWeapon', valueId: 'dagger' }],
      }),
    ).toEqual(['longsword', 'dagger']);
  });
});
