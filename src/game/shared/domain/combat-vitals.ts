export function clampHitPointsCurrent(
  current: number | null | undefined,
  max: number | null | undefined,
): number | null | undefined {
  if (current == null || max == null) return current;
  return current > max ? max : current;
}

export function hitPointsPercent(
  current: number | null | undefined,
  max: number | null | undefined,
): number | null {
  if (max == null || max <= 0 || current == null) return null;
  return Math.max(0, Math.min(100, Math.round((current / max) * 100)));
}
