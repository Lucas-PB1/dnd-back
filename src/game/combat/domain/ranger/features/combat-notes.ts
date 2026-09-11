/**
 * Notas dinâmicas do Patrulheiro. Estáticas → `phb_level_combat_note`.
 */
import { isRangerClass } from './rules';
import { addRangerSubclassNotes } from './subclass-notes';

export function rangerCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isRangerClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [];
  addRangerSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}
