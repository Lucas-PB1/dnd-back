/**
 * Notas informativas de combate do Bárbaro para a mesa (sem simular duração por turno).
 */
import { brutalStrikeDice, isBarbarianClass, rageDamageBonus } from './rules';
import { addBarbarianSubclassNotes } from './subclass-notes';

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
  if (level >= 2) {
    notes.push(
      'Sentido de Perigo: Vantagem em salvaguardas de Destreza (se não Incapacitado)',
    );
  }
  if (level >= 7) {
    notes.push(
      'Bote Instintivo: ao entrar em Fúria, mova-se até metade do Deslocamento',
    );
    notes.push('Instintos Primitivos: Vantagem na Iniciativa');
  }
  if (level >= 9) {
    const brutal = brutalStrikeDice(level);
    if (brutal) {
      notes.push(
        `Golpe Brutal: no acerto com Imprudente, pode abrir mão da Vantagem e causar +${brutal} (efeitos de empurrar etc. na mesa)`,
      );
    }
  }
  if (level >= 11) {
    notes.push(
      'Fúria Implacável: se cair a 0 PV com Fúria ativa, teste CON (CD 10+) para ficar com 1 PV',
    );
  }
  if (level >= 15) {
    notes.push(
      'Fúria Persistente: na Iniciativa pode recuperar todas as Fúrias (1× por descanso longo); Fúria dura 10 min sem extensão rodada a rodada',
    );
  }
  if (level >= 18) {
    notes.push(
      'Força Indomável: se o total de teste/salvaguarda de Força for menor que seu valor de Força, use o valor de Força',
    );
  }

  addBarbarianSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}
