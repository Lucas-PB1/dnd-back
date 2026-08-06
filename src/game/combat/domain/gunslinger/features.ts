/**
 * Notas de combate do Pistoleiro (classe + Pack 2 Pistolero).
 */

import { isGunslingerClass } from './firearm';

export function gunslingerCombatNotes(input: {
  classSlug: string;
  subclassSlug?: string | null;
  level: number;
}): string[] {
  if (!isGunslingerClass(input.classSlug)) return [];
  const notes: string[] = [];
  const { subclassSlug, level } = input;

  if (level >= 2) {
    notes.push(
      'Dado de Risco: gaste em manobras (painel). Recarrega no Descanso Curto/Longo.',
    );
  }

  if (subclassSlug === 'pistolero' && level >= 3) {
    notes.push(
      'Pistolero — Tiro a Queima-Roupa: sem Desvantagem em ataques à distância a 1,5 m de inimigo.',
    );
    notes.push(
      'Abrir o Leque e Confronto: manobras no painel (gastam Dado de Risco).',
    );
    if (level >= 6) {
      notes.push(
        'Desarmar: em crítico com Tiro no Estômago, solte um objeto a até 4,5 m (mesa).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Tempo Bala: 1×/turno, Vantagem em um ataque à distância com arma.',
      );
    }
  }

  return notes;
}
