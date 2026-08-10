import {
  isDruidClass,
  landAidDice,
  moonWildShapeTempHp,
  starryFormDice,
  wildShapeMaxUses,
  druidCombatNotes,
} from './features';

describe('druid-features', () => {
  it('identifies druid class correctly', () => {
    expect(isDruidClass('druid')).toBe(true);
    expect(isDruidClass('cleric')).toBe(false);
  });

  it('computes wild shape max uses per level', () => {
    expect(wildShapeMaxUses(1)).toBe(0);
    expect(wildShapeMaxUses(2)).toBe(2);
    expect(wildShapeMaxUses(6)).toBe(3);
    expect(wildShapeMaxUses(17)).toBe(4);
  });

  it('computes moon wild shape temp hp', () => {
    expect(moonWildShapeTempHp(3)).toBe(9);
    expect(moonWildShapeTempHp(10)).toBe(30);
  });

  it('computes land aid and starry dice', () => {
    expect(landAidDice(3)).toBe(2);
    expect(landAidDice(10)).toBe(3);
    expect(landAidDice(14)).toBe(4);
    expect(starryFormDice(3)).toBe('1d8');
    expect(starryFormDice(10)).toBe('2d8');
  });

  it('generates combat notes for base druid and subclasses', () => {
    const notes = druidCombatNotes({ classSlug: 'druid', level: 5 });
    expect(notes.some((n) => n.includes('Forma Selvagem'))).toBe(true);
    expect(notes.some((n) => n.includes('Ressurgimento Selvagem'))).toBe(true);

    const moonNotes = druidCombatNotes({ classSlug: 'druid', subclassSlug: 'moon', level: 3 });
    expect(moonNotes.some((n) => n.includes('Círculo da Lua'))).toBe(true);

    const landNotes = druidCombatNotes({ classSlug: 'druid', subclassSlug: 'land', level: 6 });
    expect(landNotes.some((n) => n.includes('Auxílio da Terra'))).toBe(true);
    expect(landNotes.some((n) => n.includes('Recuperação Natural'))).toBe(true);

    const starsNotes = druidCombatNotes({ classSlug: 'druid', subclassSlug: 'stars', level: 3 });
    expect(starsNotes.some((n) => n.includes('Forma Estelar'))).toBe(true);
  });
});
