import type { LevelCombatNoteRow } from '../../infrastructure/level-combat-note.queries';

export function filterLevelCombatNotes(
  rows: readonly LevelCombatNoteRow[],
  ownerKind: 'class' | 'subclass',
  ownerSlug: string | null | undefined,
  level: number,
): string[] {
  if (!ownerSlug) return [];
  return rows
    .filter(
      (row) =>
        row.ownerKind === ownerKind &&
        row.ownerSlug === ownerSlug &&
        level >= row.unlockLevel,
    )
    .map((row) => row.note);
}
