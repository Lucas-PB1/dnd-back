/** Garante PV atual ≤ PV máximo quando ambos estão definidos. */
export function clampHitPointsCurrent(
  current: number | null | undefined,
  max: number | null | undefined,
): number | null | undefined {
  if (current == null || max == null) return current;
  return current > max ? max : current;
}

/** PV como percentual 0–100 (ex.: visão jogador em encontros). */
export function hitPointsPercent(
  current: number | null | undefined,
  max: number | null | undefined,
): number | null {
  if (max == null || max <= 0 || current == null) return null;
  return Math.max(0, Math.min(100, Math.round((current / max) * 100)));
}
