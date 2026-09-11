/** Notas dinâmicas de subclasse de Patrulheiro. Estáticas → catálogo. */
import { feyDreadfulStrikesDie, gloomDreadAmbusherDie } from './rules';

export function addRangerSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (subclassSlug === 'fey-wanderer' && level >= 3) {
    notes.push(
      `Golpes Terríveis: +${feyDreadfulStrikesDie(level)} Psíquico 1×/turno ao acertar com arma`,
    );
  }
  if (subclassSlug === 'gloom-stalker' && level >= 3) {
    notes.push(
      'Emboscador das Sombras: +SAB na Iniciativa; Golpe Terrível +' +
        gloomDreadAmbusherDie(level) +
        ' Psíquico (usos = mod. SAB); +3 m no 1º turno',
    );
  }
}
