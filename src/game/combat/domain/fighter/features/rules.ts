/**
 * Regras numéricas de combate do Guerreiro (PHB 2024) e efeitos de subclasse.
 */

export function isFighterClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'fighter';
}

/** Ataques por Ação Atacar: 1 → 2 (nv.5) → 3 (nv.11) → 4 (nv.20). */
export function attacksPerAction(level: number): number {
  if (level >= 20) return 4;
  if (level >= 11) return 3;
  if (level >= 5) return 2;
  return 1;
}

/** Cura de Recuperar Fôlego: 1d10 + nível de Guerreiro. */
export function secondWindHealDice(level: number): string {
  return `1d10+${Math.max(1, level)}`;
}

/** Usos de Indomável: 1 (nv.9), 2 (nv.13), 3 (nv.17). */
export function indomitableMaxUses(level: number): number {
  if (level >= 17) return 3;
  if (level >= 13) return 2;
  if (level >= 9) return 1;
  return 0;
}

/** Dados de Superioridade (Mestre da Batalha): quantidade. */
export function superiorityDiceCount(level: number): number {
  if (level >= 15) return 6;
  if (level >= 7) return 5;
  if (level >= 3) return 4;
  return 0;
}

/** Faces do Dado de Superioridade: d8 → d10 (nv.10) → d12 (nv.18). */
export function superiorityDieFaces(level: number): number | null {
  if (level < 3) return null;
  if (level >= 18) return 12;
  if (level >= 10) return 10;
  return 8;
}

export function superiorityDieLabel(level: number): string | null {
  const faces = superiorityDieFaces(level);
  return faces == null ? null : `d${faces}`;
}

/**
 * Dados de Energia Psiônica (Combatente Psíquico).
 * Nível → { faces, count }
 */
export function psiEnergyDiceSchedule(level: number): {
  faces: number;
  count: number;
} | null {
  if (level < 3) return null;
  if (level >= 17) return { faces: 12, count: 12 };
  if (level >= 13) return { faces: 10, count: 10 };
  if (level >= 11) return { faces: 10, count: 8 };
  if (level >= 9) return { faces: 8, count: 8 };
  if (level >= 5) return { faces: 8, count: 6 };
  return { faces: 6, count: 4 };
}

export function psiEnergyDiceCount(level: number): number {
  return psiEnergyDiceSchedule(level)?.count ?? 0;
}

export function psiEnergyDieFaces(level: number): number | null {
  return psiEnergyDiceSchedule(level)?.faces ?? null;
}

export function psiEnergyDieLabel(level: number): string | null {
  const faces = psiEnergyDieFaces(level);
  return faces == null ? null : `d${faces}`;
}

/** Crítico do Campeão: 19–20 (nv.3), 18–20 (nv.15). */
export function championCritThreshold(level: number): number {
  if (level >= 15) return 18;
  if (level >= 3) return 19;
  return 20;
}

export function resolveFighterAttackCritThreshold(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): number {
  if (
    !isFighterClass(input.classSlug) ||
    input.subclassSlug !== 'champion' ||
    input.level == null
  ) {
    return 20;
  }
  return championCritThreshold(input.level);
}

export function hasStudiedAttacks(level: number): boolean {
  return level >= 13;
}

export function hasTacticalMaster(level: number): boolean {
  return level >= 9;
}

export function hasTacticalShift(level: number): boolean {
  return level >= 5;
}

export function hasTacticalMind(level: number): boolean {
  return level >= 2;
}
