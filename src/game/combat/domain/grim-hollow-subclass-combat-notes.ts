/**
 * Passivas / lembretes de subclasses Grim Hollow (Cap. 2).
 * Economia C063–C068 cobre botões Usar; aqui ficam efeitos contínuos e buffs condicionais.
 * HP numérico permanente: `phb_combat_modifier` (ex.: sangromancer C069).
 */
import {
  GH_CLASS_COMBAT_NOTES,
  GH_SUBCLASS_COMBAT_NOTES,
} from './grim-hollow-subclass-combat-notes-data';

export function grimHollowSubclassCombatNotes(input: {
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  const slug = input.subclassSlug;
  if (!slug) return [];
  const level = input.level ?? 1;
  const entries = GH_SUBCLASS_COMBAT_NOTES[slug];
  if (!entries?.length) return [];
  return entries.filter((e) => level >= e.minLevel).map((e) => e.text);
}

/** Passivas de classe GH (não subclasse). */
export function grimHollowClassCombatNotes(input: {
  classSlug?: string | null;
  level?: number;
}): string[] {
  const slug = input.classSlug;
  if (!slug) return [];
  const level = input.level ?? 1;
  const entries = GH_CLASS_COMBAT_NOTES[slug];
  if (!entries?.length) return [];
  return entries.filter((e) => level >= e.minLevel).map((e) => e.text);
}
