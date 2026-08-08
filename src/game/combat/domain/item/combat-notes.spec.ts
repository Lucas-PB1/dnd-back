import { itemCombatNotes } from './combat-notes';

describe('itemCombatNotes', () => {
  it('returns empty for economy-only items', () => {
    expect(itemCombatNotes({ itemSlugs: ['ring-of-barrels'] })).toEqual([]);
  });

  it('lists memento and charm passives once', () => {
    const notes = itemCombatNotes({
      itemSlugs: ['memento-mori', 'weapon-charm-blade-1', 'memento-mori'],
    });
    expect(notes.some((n) => n.includes('Salvaguardas contra a Morte'))).toBe(
      true,
    );
    expect(notes.some((n) => n.includes('+1'))).toBe(true);
    expect(
      notes.filter((n) => n.includes('Salvaguardas contra a Morte')).length,
    ).toBe(1);
  });

  it('ignores unknown slugs', () => {
    expect(itemCombatNotes({ itemSlugs: ['not-an-item'] })).toEqual([]);
  });
});
