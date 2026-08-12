import { northlandsSubclassCombatNotes } from './northlands-subclass-combat-notes';

describe('northlandsSubclassCombatNotes', () => {
  it('returns empty without subclass', () => {
    expect(northlandsSubclassCombatNotes({ level: 5 })).toEqual([]);
  });

  it('lists titan rage size at L3+', () => {
    const notes = northlandsSubclassCombatNotes({
      subclassSlug: 'path-of-the-titan',
      level: 3,
    });
    expect(notes.some((n) => /Fúria dos Gigantes/i.test(n))).toBe(true);
    expect(notes.some((n) => /Enorme/i.test(n))).toBe(false);
  });

  it('adds titan enormous note at L14', () => {
    const notes = northlandsSubclassCombatNotes({
      subclassSlug: 'path-of-the-titan',
      level: 14,
    });
    expect(notes.some((n) => /Enorme/i.test(n))).toBe(true);
  });

  it('lists viking sea-born passive', () => {
    const notes = northlandsSubclassCombatNotes({
      subclassSlug: 'viking',
      level: 3,
    });
    expect(notes.some((n) => /Nascido no Mar/i.test(n))).toBe(true);
  });

  it('lists valhalla thunder aura at L7', () => {
    const notes = northlandsSubclassCombatNotes({
      subclassSlug: 'oath-of-valhalla',
      level: 7,
    });
    expect(notes.some((n) => /Aura Trovejante/i.test(n))).toBe(true);
  });
});
