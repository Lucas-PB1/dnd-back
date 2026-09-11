/**
 * Passivas Northlands — SSOT = `phb_level_combat_note`.
 * Mantido como thin wrapper para specs / imports legados.
 */
import type { LevelCombatNoteRow } from '../../../infrastructure/level-combat-note.queries';
import { filterLevelCombatNotes } from '../level-combat-notes';

export function northlandsSubclassCombatNotes(input: {
  subclassSlug?: string | null;
  level?: number;
  catalogNotes?: readonly LevelCombatNoteRow[];
}): string[] {
  return filterLevelCombatNotes(
    input.catalogNotes ?? [],
    'subclass',
    input.subclassSlug,
    input.level ?? 1,
  );
}
