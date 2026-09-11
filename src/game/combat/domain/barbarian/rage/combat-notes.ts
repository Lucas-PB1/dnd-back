/**
 * Notas dinâmicas do Bárbaro (estado/dados). Estáticas → `phb_level_combat_note`.
 */
import { brutalStrikeDice, isBarbarianClass, rageDamageBonus } from './rules';

export function barbarianCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  rageActive?: boolean;
  recklessActive?: boolean;
}): string[] {
  if (!isBarbarianClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [];

  if (input.rageActive) {
    notes.push(
      `Fúria ativa (+${rageDamageBonus(level)} dano FOR; Resistência Contundente/Cortante/Perfurante; Vantagem em testes e salvaguardas de Força)`,
    );
  }
  if (input.recklessActive && level >= 2) {
    notes.push(
      'Ataque Imprudente: Vantagem em ataques com Força; ataques contra você têm Vantagem',
    );
  }
  if (level >= 9) {
    const brutal = brutalStrikeDice(level);
    if (brutal) {
      notes.push(
        `Golpe Brutal: no acerto com Imprudente, pode abrir mão da Vantagem e causar +${brutal} (efeitos de empurrar etc. na mesa)`,
      );
    }
  }

  return notes;
}
