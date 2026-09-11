import { filterLevelCombatNotes } from './level-combat-notes';
import type { LevelCombatNoteRow } from '../../infrastructure/level-combat-note.queries';

const CATALOG: LevelCombatNoteRow[] = [
  {
    ownerKind: 'subclass',
    ownerSlug: 'path-of-the-titan',
    unlockLevel: 3,
    note: 'Fúria dos Gigantes: ao ativar Fúria, pode tornar-se Grande.',
    sortOrder: 0,
  },
  {
    ownerKind: 'subclass',
    ownerSlug: 'path-of-the-titan',
    unlockLevel: 14,
    note: 'Fúria dos Titãs: ao ativar Fúria, pode tornar-se Enorme.',
    sortOrder: 0,
  },
  {
    ownerKind: 'class',
    ownerSlug: 'gunslinger',
    unlockLevel: 1,
    note: 'Pistoleiro: armas de fogo na mesa.',
    sortOrder: 0,
  },
];

describe('filterLevelCombatNotes', () => {
  it('returns empty without owner slug', () => {
    expect(filterLevelCombatNotes(CATALOG, 'subclass', null, 5)).toEqual([]);
  });

  it('filters by owner, kind and unlock level', () => {
    const at3 = filterLevelCombatNotes(
      CATALOG,
      'subclass',
      'path-of-the-titan',
      3,
    );
    expect(at3).toEqual([
      'Fúria dos Gigantes: ao ativar Fúria, pode tornar-se Grande.',
    ]);

    const at14 = filterLevelCombatNotes(
      CATALOG,
      'subclass',
      'path-of-the-titan',
      14,
    );
    expect(at14).toHaveLength(2);
    expect(at14.some((n) => /Enorme/i.test(n))).toBe(true);
  });

  it('filters class owners', () => {
    expect(
      filterLevelCombatNotes(CATALOG, 'class', 'gunslinger', 1),
    ).toEqual(['Pistoleiro: armas de fogo na mesa.']);
  });
});
