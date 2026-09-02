/**
 * Notas de combate do Guerreiro para a mesa (números no motor; duração/alvo na mesa).
 */
import {
  attacksPerAction,
  hasStudiedAttacks,
  hasTacticalMaster,
  hasTacticalMind,
  hasTacticalShift,
  indomitableMaxUses,
  isFighterClass,
} from './rules';
import { addFighterSubclassNotes } from './subclass-notes';

export function fighterCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  /** Labels de Matar Monstro (catálogo); omitido = sem nota de tipos. */
  dungeoneerSlayerLabels?: readonly string[];
}): string[] {
  if (!isFighterClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [];

  notes.push(`Ataques por ação: ${attacksPerAction(level)}`);
  addBaseFighterNotes(notes, level);
  addFighterSubclassNotes(
    notes,
    input.subclassSlug,
    level,
    input.dungeoneerSlayerLabels,
  );
  return notes;
}

function addBaseFighterNotes(notes: string[], level: number): void {
  if (hasTacticalMind(level)) {
    notes.push(
      'Mente Tática: ao falhar em teste de atributo, gaste Recuperar Fôlego para +1d10 (uso devolvido se ainda falhar)',
    );
  }
  if (hasTacticalShift(level)) {
    notes.push(
      'Ajuste Tático: ao usar Recuperar Fôlego, mova-se até metade do Deslocamento sem provocar AO',
    );
  }
  if (hasTacticalMaster(level)) {
    notes.push(
      'Mestre Tático: pode substituir a maestria da arma por Empurrar, Drenar ou Lentidão neste ataque',
    );
  }
  if (indomitableMaxUses(level) > 0) {
    notes.push(
      `Indomável: rerrolar salvaguarda com +${level} (até ${indomitableMaxUses(level)}× por descanso longo)`,
    );
  }
  if (hasStudiedAttacks(level)) {
    notes.push(
      'Ataques Estudados: se errar um ataque, vantagem no próximo ataque contra o mesmo alvo até o fim do próximo turno',
    );
  }
}
