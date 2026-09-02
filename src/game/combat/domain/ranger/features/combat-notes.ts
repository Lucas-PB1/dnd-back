/**
 * Notas de combate do Patrulheiro para a mesa (números no motor; duração/alvo na mesa).
 */
import { isRangerClass } from './rules';
import { addRangerSubclassNotes } from './subclass-notes';

export function rangerCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isRangerClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [
    `Inimigo Favorito: Marca do Predador sempre preparada; usos gratuitos = PB (recuperam no Descanso Longo)`,
  ];
  addBaseRangerNotes(notes, level);
  addRangerSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseRangerNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Explorador Hábil: Especialização em 1 perícia e 2 idiomas',
    );
  }
  if (level >= 5) notes.push('Ataque Extra: dois ataques na ação Atacar');
  if (level >= 6) {
    notes.push(
      'Errante: +3 m de Deslocamento (sem Armadura Pesada); Escalada e Natação iguais ao Deslocamento',
    );
  }
  if (level >= 9) notes.push('Especialista: Especialização em mais 2 perícias');
  if (level >= 10) {
    notes.push(
      'Incansável: ação Usar Magia concede 1d8 + SAB PV temporários (usos = mod. SAB); Descanso Curto reduz Exaustão em 1',
    );
  }
  if (level >= 13) {
    notes.push(
      'Predador Implacável: dano não quebra Concentração da Marca do Predador',
    );
  }
  if (level >= 14) {
    notes.push(
      'Véu da Natureza: Ação Bônus para Invisível até o fim do próximo turno (usos = mod. SAB)',
    );
  }
  if (level >= 17) {
    notes.push(
      'Caçador Preciso: Vantagem nos ataques contra a criatura marcada',
    );
  }
  if (level >= 18) {
    notes.push('Sentidos Selvagens: Visão às Cegas 9 m');
  }
  if (level >= 20) {
    notes.push('Matador de Inimigos Favoritos: dado da Marca do Predador vira d10');
  }
}
