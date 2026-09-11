import {
  grimHollowClassCombatNotes,
  grimHollowSubclassCombatNotes,
} from './grim-hollow-subclass-combat-notes';
import {
  GH_CLASS_COMBAT_NOTES,
  GH_SUBCLASS_COMBAT_NOTES,
} from './grim-hollow-subclass-combat-notes-data';
import type { LevelCombatNoteRow } from '../../../infrastructure/level-combat-note.queries';

function catalogFromRecord(
  record: typeof GH_SUBCLASS_COMBAT_NOTES,
  ownerKind: 'class' | 'subclass',
): LevelCombatNoteRow[] {
  return Object.entries(record).flatMap(([slug, entries]) =>
    entries.map((entry, sortOrder) => ({
      ownerKind,
      ownerSlug: slug,
      unlockLevel: entry.minLevel,
      note: entry.text,
      sortOrder,
    })),
  );
}

const CATALOG_NOTES: LevelCombatNoteRow[] = [
  ...catalogFromRecord(GH_SUBCLASS_COMBAT_NOTES, 'subclass'),
  ...catalogFromRecord(GH_CLASS_COMBAT_NOTES, 'class'),
];

describe('grimHollowSubclassCombatNotes', () => {
  it('returns empty without subclass', () => {
    expect(
      grimHollowSubclassCombatNotes({
        level: 5,
        catalogNotes: CATALOG_NOTES,
      }),
    ).toEqual([]);
  });

  it('lists circleof-entropy ironskin from L3', () => {
    const notes = grimHollowSubclassCombatNotes({
      subclassSlug: 'circleof-entropy',
      level: 3,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /CA base 17/i.test(n))).toBe(true);
  });

  it('lists eldritch psychic resist from L6', () => {
    const notes = grimHollowSubclassCombatNotes({
      subclassSlug: 'eldritch-domain',
      level: 6,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /psíquico/i.test(n))).toBe(true);
    expect(
      grimHollowSubclassCombatNotes({
        subclassSlug: 'eldritch-domain',
        level: 5,
        catalogNotes: CATALOG_NOTES,
      }),
    ).toEqual([]);
  });

  it('lists sangromancer vigor from L6', () => {
    const notes = grimHollowSubclassCombatNotes({
      subclassSlug: 'sangromancer',
      level: 6,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /Vigor Sanguíneo/i.test(n))).toBe(true);
  });

  it('lists nightwatcher darkvision from L3', () => {
    const notes = grimHollowSubclassCombatNotes({
      subclassSlug: 'nightwatcher',
      level: 3,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /18 m/i.test(n))).toBe(true);
  });

  it('covers all 40 GH subclasses', () => {
    expect(Object.keys(GH_SUBCLASS_COMBAT_NOTES)).toHaveLength(40);
  });

  it('lists carver-guild monster hide from L7', () => {
    const notes = grimHollowSubclassCombatNotes({
      subclassSlug: 'carver-guild',
      level: 7,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /Couro de Monstro/i.test(n))).toBe(true);
  });
});

describe('grimHollowClassCombatNotes', () => {
  it('lists monster hunter lair sense from L14 only', () => {
    const before = grimHollowClassCombatNotes({
      classSlug: 'monster-hunter',
      level: 8,
      catalogNotes: CATALOG_NOTES,
    });
    expect(before.some((n) => /Senso do Covil/i.test(n))).toBe(false);

    const notes = grimHollowClassCombatNotes({
      classSlug: 'monster-hunter',
      level: 14,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /Senso do Covil/i.test(n))).toBe(true);
    expect(notes.some((n) => /Defesa Erudita/i.test(n))).toBe(true);
  });

  it('lists knowledgeable defense from L9', () => {
    const notes = grimHollowClassCombatNotes({
      classSlug: 'monster-hunter',
      level: 9,
      catalogNotes: CATALOG_NOTES,
    });
    expect(notes.some((n) => /Defesa Erudita/i.test(n))).toBe(true);
  });
});
