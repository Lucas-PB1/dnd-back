/** Cursemarked (Northlands) — brackets d20 + anti-overlap (mesa). */

export const CURSEMARKED_THREAD_SLUG = 'cursemarked';
export const CURSEMARKED_BRACKET_LOCK = 'cursemarked-bracket-lock';
export const CURSEMARKED_GREATER_SACRIFICE = 'cursemarked-greater-sacrifice';

export const CURSEMARKED_BRACKET_BENEFITS = [
  'tides-of-fate',
  'burdens-shield',
  'threads-entwined',
  'two-edged-gift',
] as const;

export type CursemarkedBracketBenefit =
  (typeof CURSEMARKED_BRACKET_BENEFITS)[number];

export type CursemarkedRollKind = 'attack' | 'skill' | 'save';

const MAX_KEPT: Record<CursemarkedBracketBenefit, number> = {
  'tides-of-fate': 3,
  'burdens-shield': 5,
  'threads-entwined': 7,
  'two-edged-gift': 9,
};

const KINDS: Record<CursemarkedBracketBenefit, readonly CursemarkedRollKind[]> = {
  'tides-of-fate': ['save'],
  'burdens-shield': ['save', 'skill'],
  'threads-entwined': ['save', 'skill', 'attack'],
  'two-edged-gift': ['save', 'skill', 'attack'],
};

const NOTES: Record<CursemarkedBracketBenefit, string> = {
  'tides-of-fate':
    'Cursemarked — Marés do Destino: −3 m de deslocamento; aliado +3 m. Anti-overlap até o início do seu próximo turno.',
  'burdens-shield':
    'Cursemarked — Escudo do Fardo: −2 CA; aliado +2 CA. Anti-overlap até o início do seu próximo turno.',
  'threads-entwined':
    'Cursemarked — Fios Entrelaçados: sem Ações Bônus/Reações; aliado ganha Reação (Disparar/Ajudar/Esconder-se/ataque). Anti-overlap até o início do seu próximo turno.',
  'two-edged-gift':
    'Cursemarked — Dádiva de Dois Gumes: metade do dano; próximo acerto do aliado causa dano máximo. Anti-overlap até o início do seu próximo turno.',
};

export function pickHighestCursemarkedBracket(
  benefitKeys: readonly string[],
): CursemarkedBracketBenefit | null {
  let best: CursemarkedBracketBenefit | null = null;
  let bestIdx = -1;
  for (const key of benefitKeys) {
    const idx = (CURSEMARKED_BRACKET_BENEFITS as readonly string[]).indexOf(key);
    if (idx > bestIdx) {
      bestIdx = idx;
      best = key as CursemarkedBracketBenefit;
    }
  }
  return best;
}

export function cursemarkedBracketTriggers(input: {
  benefit: CursemarkedBracketBenefit;
  kind: CursemarkedRollKind;
  kept: number;
}): boolean {
  const { benefit, kind, kept } = input;
  if (kept < 1 || kept > MAX_KEPT[benefit]) return false;
  return KINDS[benefit].includes(kind);
}

export function cursemarkedBracketNote(
  benefit: CursemarkedBracketBenefit,
): string {
  return NOTES[benefit];
}
