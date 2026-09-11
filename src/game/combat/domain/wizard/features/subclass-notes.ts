/** Notas dinâmicas de subclasse de Mago. Estáticas → catálogo. */
import { portentDiceCount } from './rules';

export function addWizardSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'diviner') {
    const count = portentDiceCount(level);
    notes.push(
      `Adivinhador: Presságio (guarde ${count}d20 no início do dia e substitua qualquer d20 seu ou de outra criatura).`,
    );
  }
}
