/**
 * Notas dinâmicas do Bruxo. Estáticas → `phb_level_combat_note`.
 */
import {
  isWarlockClass,
  magicalCunningSlotRecoveryCount,
  warlockInvocationLimit,
  warlockPactSlotCount,
  warlockPactSlotLevel,
} from './rules';
import { addWarlockSubclassNotes } from './subclass-notes';

export function warlockCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isWarlockClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const slotLvl = warlockPactSlotLevel(level);
  const slotQty = warlockPactSlotCount(level);

  const notes = [
    `Magia de Pacto (${slotQty} slots de ${slotLvl}º círculo): todos os slots recarregam em Descanso Curto ou Longo.`,
  ];

  const invocationLimit = warlockInvocationLimit(level);
  if (invocationLimit > 0) {
    notes.push(
      `Invocações Místicas: até ${invocationLimit} invocação(ões) conhecida(s) (veja o painel/ficha).`,
    );
  }
  if (level >= 2) {
    const recover = magicalCunningSlotRecoveryCount(level);
    notes.push(
      `Astúcia Mágica: rito de 1 min recupera ${recover} slot(s) de Pacto (1×/Descanso Longo).`,
    );
  }
  addWarlockSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}
