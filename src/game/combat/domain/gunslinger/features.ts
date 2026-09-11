/**
 * Notas de combate do Pistoleiro — estáticas migradas para `phb_level_combat_note`.
 */

import { isGunslingerClass } from './firearm';

export function gunslingerCombatNotes(input: {
  classSlug: string;
  subclassSlug?: string | null;
  level: number;
}): string[] {
  if (!isGunslingerClass(input.classSlug)) return [];
  return [];
}
