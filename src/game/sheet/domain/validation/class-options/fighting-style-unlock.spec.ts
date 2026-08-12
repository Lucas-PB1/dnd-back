import {
  classHasFightingStylePick,
  fightingStyleUnlockLevel,
} from './fighting-style-unlock';

describe('fighting-style-unlock', () => {
  it('unlocks fighter at 1, paladin and ranger at 2', () => {
    expect(fightingStyleUnlockLevel('fighter')).toBe(1);
    expect(fightingStyleUnlockLevel('paladin')).toBe(2);
    expect(fightingStyleUnlockLevel('ranger')).toBe(2);
    expect(fightingStyleUnlockLevel('cleric')).toBeNull();
    expect(classHasFightingStylePick('fighter', 1)).toBe(true);
    expect(classHasFightingStylePick('paladin', 1)).toBe(false);
    expect(classHasFightingStylePick('paladin', 2)).toBe(true);
    expect(classHasFightingStylePick('ranger', 2)).toBe(true);
  });
});
