import type { SubclassCombatNoteEntry } from './types';

/** Passivas de classe GH (não subclasse). */
export const GH_CLASS_COMBAT_NOTES: Record<string, SubclassCombatNoteEntry[]> =
  {
    'monster-hunter': [
      {
        minLevel: 9,
        text: 'Defesa Erudita: em salvaguardas forçadas por tipos do Grimório, pode usar salvaguarda de Inteligência.',
      },
      {
        minLevel: 14,
        text: 'Senso do Covil: vantagem e resistência a ações de covil/região e Ações Lendárias de tipos no Grimório.',
      },
    ],
  };
