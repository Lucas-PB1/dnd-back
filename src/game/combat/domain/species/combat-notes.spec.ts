import { speciesCombatNotes } from './combat-notes';

describe('speciesCombatNotes', () => {
  it('lists dwarf passive reminders', () => {
    const notes = speciesCombatNotes({ speciesSlug: 'dwarf' });
    expect(notes.some((n) => /Visão no Escuro 36/i.test(n))).toBe(true);
    expect(notes.some((n) => /Tenacidade/i.test(n))).toBe(true);
    expect(notes.some((n) => /Sismiconsciência|Conhecimento/i.test(n))).toBe(
      false,
    );
  });

  it('uses dragon ancestry for resistance note', () => {
    const notes = speciesCombatNotes({
      speciesSlug: 'dragonborn',
      speciesChoices: [{ choiceKind: 'dragon_ancestry', choiceSlug: 'red' }],
    });
    expect(notes.some((n) => /Ígneo/i.test(n))).toBe(true);
  });

  it('notes marionette reach for geppettin', () => {
    const notes = speciesCombatNotes({
      speciesSlug: 'geppettin',
      speciesChoices: [
        { choiceKind: 'geppettin_construction', choiceSlug: 'marionette' },
      ],
    });
    expect(notes.some((n) => /1,5 m/i.test(n))).toBe(true);
  });

  it('lists bearfolk Northlands passives', () => {
    const notes = speciesCombatNotes({ speciesSlug: 'bearfolk' });
    expect(notes.some((n) => /Pelagem Espessa/i.test(n))).toBe(true);
    expect(notes.some((n) => /Coração Selvagem/i.test(n))).toBe(true);
  });
});
