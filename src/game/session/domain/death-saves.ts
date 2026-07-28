/** Clamp death save counters to the PHB range 0–3. */
export function clampDeathSaveCount(value: number): number {
  if (!Number.isFinite(value)) return 0;
  return Math.max(0, Math.min(3, Math.trunc(value)));
}

export function resetDeathSaves(): {
  deathSaveSuccesses: number;
  deathSaveFailures: number;
} {
  return { deathSaveSuccesses: 0, deathSaveFailures: 0 };
}
