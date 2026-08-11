import { itemCombatNotes } from './combat-notes';

describe('itemCombatNotes', () => {
  it('returns empty without properties map', () => {
    expect(itemCombatNotes({ itemSlugs: ['memento-mori'] })).toEqual([]);
  });

  it('lists combatNotes from catalog properties once', () => {
    const propertiesBySlug = new Map<string, Record<string, unknown> | null>([
      [
        'memento-mori',
        {
          combatNotes: [
            'Após ler: Vantagem em Salvaguardas contra a Morte; morre só com 5 falhas (exceto morte descrita na carta).',
          ],
        },
      ],
      ['weapon-charm-blade-1', { weaponCharm: { kind: 'blade' } }],
    ]);
    const notes = itemCombatNotes({
      itemSlugs: ['memento-mori', 'weapon-charm-blade-1', 'memento-mori'],
      propertiesBySlug,
    });
    expect(notes.some((n) => n.includes('Salvaguardas contra a Morte'))).toBe(
      true,
    );
    expect(notes.some((n) => n.includes('+1'))).toBe(false);
    expect(
      notes.filter((n) => n.includes('Salvaguardas contra a Morte')).length,
    ).toBe(1);
  });

  it('ignores unknown slugs', () => {
    expect(
      itemCombatNotes({
        itemSlugs: ['not-an-item'],
        propertiesBySlug: new Map(),
      }),
    ).toEqual([]);
  });
});
