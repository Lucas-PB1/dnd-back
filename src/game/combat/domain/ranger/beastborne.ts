const BESTIAL_ASPECT_MIN = 0;
const BESTIAL_ASPECT_MAX = 5;

/** Aspecto ≥1: Carnificina +2; Fúria Sedenta (nv.11): +3. */
export function carnificinaDamageBonus(input: {
  subclassSlug?: string | null;
  characterLevel: number;
  bestialAspectLevel: number;
}): number {
  if (input.subclassSlug !== 'beastborne') return 0;
  if (input.characterLevel < 3) return 0;
  if (clampBestialAspectLevel(input.bestialAspectLevel) < 1) return 0;
  return input.characterLevel >= 11 ? 3 : 2;
}

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
