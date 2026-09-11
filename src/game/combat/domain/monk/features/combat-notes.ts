/**
 * Notas dinâmicas do Monge (dado/metros). Estáticas → `phb_level_combat_note`.
 */
import {
  isMonkClass,
  martialArtsDie,
  unarmoredMovementBonusMeters,
} from './rules';

export function monkCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isMonkClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes = [
    `Artes Marciais: Ataque Desarmado e armas de Monge usam ${martialArtsDie(
      level,
    )} e o melhor de FOR/DES (sem armadura nem escudo)`,
  ];

  if (level >= 2) {
    notes.push(
      `Movimento sem Armadura: +${unarmoredMovementBonusMeters({
        classSlug: 'monk',
        level,
      })} m de Deslocamento`,
    );
  }

  return notes;
}
