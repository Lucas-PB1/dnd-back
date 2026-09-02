/**
 * Notas de combate do Paladino para a mesa (números no motor; duração/alvo na mesa).
 */
import { auraRangeMeters, isPaladinClass } from './rules';
import { addPaladinSubclassNotes } from './subclass-notes';

export function paladinCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isPaladinClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [
    'Mãos Consagradas: reserva de cura = 5 × nível (Ação Bônus; 5 PV removem Envenenado)',
  ];

  addBasePaladinNotes(notes, level);
  addPaladinSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBasePaladinNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Destruição Divina: gaste um espaço de magia no acerto para +2d8 Radiante (+1d8 por círculo acima do 1º; +1d8 vs Corruptor/Morto-vivo)',
    );
  }
  if (level >= 3) {
    notes.push(
      'Canalizar Divindade: Sentido Divino e opções do juramento (usos por descanso)',
    );
  }
  if (level >= 5) notes.push('Ataque Extra: dois ataques na ação Atacar');
  if (level >= 6) {
    notes.push(
      `Aura de Proteção (${auraRangeMeters(level)} m): você e aliados somam o mod. de Carisma às salvaguardas`,
    );
  }
  if (level >= 9) {
    notes.push('Repudiar Inimigos: Canalizar Divindade para Amedrontar inimigos');
  }
  if (level >= 10) {
    notes.push('Aura de Coragem: imunidade a Amedrontado na aura');
  }
  if (level >= 11) {
    notes.push('Golpes Radiantes: +1d8 Radiante em cada ataque corpo a corpo');
  }
  if (level >= 14) {
    notes.push(
      'Toque Restaurador: gaste 5 PV das Mãos Consagradas para remover condições',
    );
  }
  if (level >= 18) notes.push('Aura Expandida: alcance das auras vai a 9 m');
}
