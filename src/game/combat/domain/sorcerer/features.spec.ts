import {
  isSorcererClass,
  sorceryPointCostToCreateSlot,
  sorceryPointsMax,
  sorcererCombatNotes,
} from './features';

describe('sorcerer-features', () => {
  it('identifies sorcerer class correctly', () => {
    expect(isSorcererClass('sorcerer')).toBe(true);
    expect(isSorcererClass('wizard')).toBe(false);
  });

  it('computes sorcery points max per level (min 0 at level 1)', () => {
    expect(sorceryPointsMax(1)).toBe(0);
    expect(sorceryPointsMax(2)).toBe(2);
    expect(sorceryPointsMax(5)).toBe(5);
    expect(sorceryPointsMax(20)).toBe(20);
  });

  it('computes sorcery point costs to create spell slots', () => {
    expect(sorceryPointCostToCreateSlot(1)).toBe(2);
    expect(sorceryPointCostToCreateSlot(2)).toBe(3);
    expect(sorceryPointCostToCreateSlot(3)).toBe(5);
    expect(sorceryPointCostToCreateSlot(4)).toBe(6);
    expect(sorceryPointCostToCreateSlot(5)).toBe(7);
    expect(() => sorceryPointCostToCreateSlot(6)).toThrow();
  });

  it('combat notes migrated to catalog (local function is empty)', () => {
    expect(sorcererCombatNotes({ classSlug: 'sorcerer', level: 5 })).toEqual([]);
    expect(
      sorcererCombatNotes({
        classSlug: 'sorcerer',
        subclassSlug: 'draconic',
        level: 3,
      }),
    ).toEqual([]);
  });
});
