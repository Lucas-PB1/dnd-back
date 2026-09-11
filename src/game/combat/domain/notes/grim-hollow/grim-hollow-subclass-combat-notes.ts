/**
 * Passivas / lembretes de subclasses Grim Hollow (Cap. 2).
 * SSOT: `rpg.phb_level_combat_note`. Economia C063–C068 cobre botões Usar.
 */
import type { LevelCombatNoteRow } from '../../../infrastructure/level-combat-note.queries';
import { filterLevelCombatNotes } from '../level-combat-notes';

export { filterLevelCombatNotes } from '../level-combat-notes';

export function grimHollowSubclassCombatNotes(input: {
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

/** Passivas de classe GH (não subclasse). */
export function grimHollowClassCombatNotes(input: {
  classSlug?: string | null;
  level?: number;
  catalogNotes?: readonly LevelCombatNoteRow[];
}): string[] {
  return filterLevelCombatNotes(
    input.catalogNotes ?? [],
    'class',
    input.classSlug,
    input.level ?? 1,
  );
}
