const BESTIAL_ASPECT_MIN = 0;
const BESTIAL_ASPECT_MAX = 5;

export function clampBestialAspectLevel(n: number): number {
  if (!Number.isFinite(n)) return BESTIAL_ASPECT_MIN;
  return Math.min(
    BESTIAL_ASPECT_MAX,
    Math.max(BESTIAL_ASPECT_MIN, Math.trunc(n)),
  );
}

/** Notas de benefícios acumulados até o nível (catálogo injetado). */
export function bestialAspectBenefits(
  catalog: readonly { level: number; note: string }[],
  level: number,
): string[] {
  const clamped = clampBestialAspectLevel(level);
  return catalog
    .filter((entry) => entry.level <= clamped)
    .map((entry) => entry.note);
}
