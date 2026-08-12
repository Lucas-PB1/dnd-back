/**
 * Golpes de Sangue (Blood Hound) — custos e rótulos.
 * Espelha H003 / H007 (value_id das opções); não lista subclassSlug.
 */

export const BLOOD_STRIKE_COST_DICE: Readonly<Record<string, string>> = {
  'bewitching-strike': '1d8',
  'bloodboil-strike': '1d6',
  'bloodshard-strike': '1d8',
  'constraining-strike': '1d8',
  'exiling-strike': '1d10',
  'hunting-strike': '1d4',
  'shadowblood-strike': '1d6',
  'thunderblood-strike': '1d4',
  'withering-strike': '1d6',
};

export const BLOOD_STRIKE_LABELS: Readonly<Record<string, string>> = {
  'bewitching-strike': 'Golpe Enfeitiçante',
  'bloodboil-strike': 'Golpe Ferver-Sangue',
  'bloodshard-strike': 'Golpe Estilhaço-Sangue',
  'constraining-strike': 'Golpe Constritor',
  'exiling-strike': 'Golpe do Exílio',
  'hunting-strike': 'Golpe da Caça',
  'shadowblood-strike': 'Golpe Sangue-Sombra',
  'thunderblood-strike': 'Golpe Sangue-Trovão',
  'withering-strike': 'Golpe Definhante',
};

export const BLOOD_STRIKE_RESOURCE_SLUG = 'blood-strike';

/** Sangue da Criação (L10): rerrolar custo e ficar com o menor. */
export function canTakeLowerBloodCost(level: number): boolean {
  return level >= 10;
}

/** Sinfonia de Sangue (L15): cura = mod. CON (mín. 1) ao usar golpe. */
export function bloodSymphonyHealAmount(constitutionModifier: number): number {
  return Math.max(1, constitutionModifier);
}

export function bloodStrikeCostDice(optionSlug: string): string | null {
  return BLOOD_STRIKE_COST_DICE[optionSlug] ?? null;
}

export function bloodStrikeLabel(optionSlug: string): string {
  return BLOOD_STRIKE_LABELS[optionSlug] ?? optionSlug;
}
