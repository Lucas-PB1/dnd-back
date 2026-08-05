import {
  healingLightDiceMax,
  isWarlockClass,
  warlockCombatNotes,
  warlockPactSlotCount,
  warlockPactSlotLevel,
} from './warlock-features';

describe('warlock-features', () => {
  it('identifies warlock class correctly', () => {
    expect(isWarlockClass('warlock')).toBe(true);
    expect(isWarlockClass('sorcerer')).toBe(false);
  });

  it('computes pact slot level by warlock level', () => {
    expect(warlockPactSlotLevel(1)).toBe(1);
    expect(warlockPactSlotLevel(3)).toBe(2);
    expect(warlockPactSlotLevel(5)).toBe(3);
    expect(warlockPactSlotLevel(7)).toBe(4);
    expect(warlockPactSlotLevel(9)).toBe(5);
    expect(warlockPactSlotLevel(20)).toBe(5);
  });

  it('computes pact slot count by warlock level', () => {
    expect(warlockPactSlotCount(1)).toBe(1);
    expect(warlockPactSlotCount(2)).toBe(2);
    expect(warlockPactSlotCount(10)).toBe(2);
    expect(warlockPactSlotCount(11)).toBe(3);
    expect(warlockPactSlotCount(17)).toBe(4);
  });

  it('computes celestial healing light dice max pool', () => {
    expect(healingLightDiceMax(3)).toBe(4);
    expect(healingLightDiceMax(10)).toBe(11);
  });

  it('generates combat notes for base warlock and subclasses', () => {
    const notes = warlockCombatNotes({ classSlug: 'warlock', level: 5 });
    expect(notes.some((n) => n.includes('Magia de Pacto'))).toBe(true);
    expect(notes.some((n) => n.includes('Contato Arcano'))).toBe(true);

    const fiendNotes = warlockCombatNotes({ classSlug: 'warlock', subclassSlug: 'fiend', level: 3 });
    expect(fiendNotes.some((n) => n.includes('Sorte do Próprio Inferno'))).toBe(true);

    const celestialNotes = warlockCombatNotes({ classSlug: 'warlock', subclassSlug: 'celestial', level: 3 });
    expect(celestialNotes.some((n) => n.includes('Luz Curativa'))).toBe(true);
  });
});
