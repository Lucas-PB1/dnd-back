/**
 * Notas de combate do Monge para a mesa (números no motor; duração/alvo na mesa).
 */
import {
  isMonkClass,
  martialArtsDie,
  unarmoredMovementBonusMeters,
} from './rules';
import { addMonkSubclassNotes } from './subclass-notes';

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

  addBaseMonkNotes(notes, level);
  addMonkSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseMonkNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Foco do Monge: Torrente de Golpes, Defesa Paciente e Passos do Vento (Pontos de Foco)',
    );
    notes.push(
      `Movimento sem Armadura: +${unarmoredMovementBonusMeters({
        classSlug: 'monk',
        level,
      })} m de Deslocamento`,
    );
  }
  if (level >= 3) {
    notes.push('Defletir Ataques: Reação reduz dano corpo a corpo/à distância');
  }
  if (level >= 4) notes.push('Queda Lenta: Reação reduz dano de queda');
  if (level >= 5) {
    notes.push('Ataque Extra: dois ataques na ação Atacar');
    notes.push(
      'Golpe Atordoante: gaste 1 Foco no acerto para forçar salvaguarda de Constituição',
    );
  }
  if (level >= 6) notes.push('Golpes Potencializados: dano pode ser Energético');
  if (level >= 7) {
    notes.push(
      'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha, metade',
    );
  }
  if (level >= 10) notes.push('Foco Aprimorado: aprimora Foco do Monge');
  if (level >= 13) notes.push('Defletir Energia: Defletir contra qualquer dano');
  if (level >= 14) {
    notes.push(
      'Sobrevivente Disciplinado: proficiência em todas as salvaguardas; 1 Foco para rerrolar',
    );
  }
  if (level >= 18) {
    notes.push('Defesa Superior: 3 Foco para Resistência a quase tudo (1 min)');
  }
}
