/**
 * Notas dinâmicas do Paladino (alcance de aura). Estáticas → `phb_level_combat_note`.
 */
import { auraRangeMeters, isPaladinClass } from './rules';

export function paladinCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isPaladinClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  if (level < 6) return [];

  return [
    `Aura de Proteção (${auraRangeMeters(level)} m): você e aliados somam o mod. de Carisma às salvaguardas`,
  ];
}
