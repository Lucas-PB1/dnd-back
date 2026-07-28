export type InitiativeSortable = {
  combatantId: string;
  initiativeTotal: number | null;
  initiativeModifier: number | null;
  displayName: string;
  isActive: boolean;
};

/** Ordem de iniciativa PHB: total desc → modificador desc → nome asc. Inativos no fim. */
export function compareInitiativeOrder(
  a: InitiativeSortable,
  b: InitiativeSortable,
): number {
  if (a.isActive !== b.isActive) return a.isActive ? -1 : 1;
  const totalA = a.initiativeTotal;
  const totalB = b.initiativeTotal;
  if (totalA == null && totalB == null) {
    return a.displayName.localeCompare(b.displayName, 'pt');
  }
  if (totalA == null) return 1;
  if (totalB == null) return -1;
  if (totalB !== totalA) return totalB - totalA;
  const modA = a.initiativeModifier ?? 0;
  const modB = b.initiativeModifier ?? 0;
  if (modB !== modA) return modB - modA;
  return a.displayName.localeCompare(b.displayName, 'pt');
}

export function sortCombatantsByInitiative<T extends InitiativeSortable>(
  rows: readonly T[],
): T[] {
  return [...rows].sort(compareInitiativeOrder);
}

export function advanceEncounterTurn(input: {
  currentTurnIndex: number;
  round: number;
  activeCount: number;
}): { currentTurnIndex: number; round: number } {
  if (input.activeCount <= 0) {
    return { currentTurnIndex: 0, round: input.round };
  }
  const next = input.currentTurnIndex + 1;
  if (next >= input.activeCount) {
    return { currentTurnIndex: 0, round: input.round + 1 };
  }
  return { currentTurnIndex: next, round: input.round };
}

/** PV como percentual 0–100 para jogadores (criaturas). */
export function hitPointsPercent(
  current: number | null | undefined,
  max: number | null | undefined,
): number | null {
  if (max == null || max <= 0 || current == null) return null;
  return Math.max(0, Math.min(100, Math.round((current / max) * 100)));
}
