/**
 * Notas dinâmicas do Mago. Estáticas → `phb_level_combat_note`.
 */
import {
  arcaneRecoveryMaxSlotLevels,
  isWizardClass,
} from './rules';
import { addWizardSubclassNotes } from './subclass-notes';

export function wizardCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isWizardClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const maxLevels = arcaneRecoveryMaxSlotLevels(level);

  const notes = [
    `Recuperação Arcana: 1× por dia no Descanso Curto, recupe slots de magia cuja soma dos níveis seja até ${maxLevels} (até 5º círculo).`,
  ];

  addWizardSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}
