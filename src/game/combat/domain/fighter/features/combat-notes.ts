/**
 * Notas dinâmicas do Guerreiro (contagens/dados). Estáticas → `phb_level_combat_note`.
 */
import {
  attacksPerAction,
  indomitableMaxUses,
  isFighterClass,
} from './rules';
import { addFighterSubclassNotes } from './subclass-notes';

export function fighterCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  dungeoneerSlayerLabels?: readonly string[];
}): string[] {
  if (!isFighterClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [];

  notes.push(`Ataques por ação: ${attacksPerAction(level)}`);
  if (indomitableMaxUses(level) > 0) {
    notes.push(
      `Indomável: rerrolar salvaguarda com +${level} (até ${indomitableMaxUses(level)}× por descanso longo)`,
    );
  }
  addFighterSubclassNotes(
    notes,
    input.subclassSlug,
    level,
    input.dungeoneerSlayerLabels,
  );
  return notes;
}
