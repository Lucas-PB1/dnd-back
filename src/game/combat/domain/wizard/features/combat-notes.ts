/**
 * Notas de combate do Mago para a mesa (números no motor; duração/alvo na mesa).
 */
import {
  arcaneRecoveryMaxSlotLevels,
  isWizardClass,
} from './rules';
import { addWizardSubclassNotes } from './subclass-notes';

export function wizardCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isWizardClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const maxLevels = arcaneRecoveryMaxSlotLevels(level);

  const notes = [
    `Recuperação Arcana: 1× por dia no Descanso Curto, recupe slots de magia cuja soma dos níveis seja até ${maxLevels} (até 5º círculo).`,
    'Ritualista Arcano: conjure magias de ritual diretamente do seu Grimório sem precisar tê-las preparadas.',
  ];

  addBaseWizardNotes(notes, level);
  addWizardSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseWizardNotes(notes: string[], level: number): void {
  if (level >= 18) {
    notes.push(
      'Dominância de Magias: escolha 1º e 2º círculo na aba Magias; conjure à vontade sem espaço.',
    );
  }
  if (level >= 20) {
    notes.push(
      'Assinatura de Magia: 2 magias de 3º círculo preparadas sempre disponíveis; 1× por descanso longo conjure cada uma sem gastar slot.',
    );
  }
}
