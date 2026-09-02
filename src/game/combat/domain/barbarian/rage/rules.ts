/**
 * Regras numéricas de combate do Bárbaro (PHB 2024): Fúria, Golpe Brutal e Fanático.
 * Fonte: features de classe; o motor só aplica números.
 */

export function isBarbarianClass(
  classSlug: string | null | undefined,
): boolean {
  return classSlug === 'barbarian';
}

/** Dano da Fúria (coluna da tabela Características de Bárbaro). */
export function rageDamageBonus(level: number): number {
  if (level >= 16) return 4;
  if (level >= 9) return 3;
  if (level >= 1) return 2;
  return 0;
}

/**
 * Golpe Brutal: dados extras no acerto (abre mão da vantagem do Imprudente).
 * 1d10 (nv.9–16), 2d10 (nv.17+).
 */
export function brutalStrikeDice(level: number): string | null {
  if (level >= 17) return '2d10';
  if (level >= 9) return '1d10';
  return null;
}

/** Tipos de dano com Resistência enquanto a Fúria está ativa. */
export const RAGE_DAMAGE_RESISTANCES = [
  'Contundente',
  'Cortante',
  'Perfurante',
] as const;

export function appliesRageDamageBonus(input: {
  classSlug?: string | null;
  level?: number;
  rageActive?: boolean;
  mode: 'melee' | 'ranged';
  abilitySlug: 'forca' | 'destreza';
}): number {
  if (
    !input.rageActive ||
    !isBarbarianClass(input.classSlug) ||
    input.mode !== 'melee' ||
    input.abilitySlug !== 'forca' ||
    input.level == null
  ) {
    return 0;
  }
  return rageDamageBonus(input.level);
}

/** Movimento Rápido (nv.5+): +3 m enquanto sem armadura pesada (não modelamos armadura aqui). */
export function fastMovementBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isBarbarianClass(input.classSlug) || (input.level ?? 0) < 5) return 0;
  return 3;
}

/** Fúria Divina (Fanático): 1d6 + metade do nível, uma vez por turno enquanto enfurecido. */
export function divineFuryExtraDice(level: number): string {
  const half = Math.floor(level / 2);
  return half > 0 ? `1d6+${half}` : '1d6';
}

export function hasDivineFury(input: {
  subclassSlug?: string | null;
  level?: number;
}): boolean {
  return input.subclassSlug === 'zealot' && (input.level ?? 0) >= 3;
}

/** Dados de Campeão dos Deuses (Fanático): 4→5→6→7. */
export function zealotHealingDiceCount(level: number): number {
  if (level >= 17) return 7;
  if (level >= 12) return 6;
  if (level >= 6) return 5;
  if (level >= 3) return 4;
  return 0;
}
