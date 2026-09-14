/** Faixa de CR máximo da Forma Selvagem base (PHB 2024). */
export type WildShapeCrBand = {
  minLevel: number;
  /** CR máximo como número (1/4 → 0.25). */
  crMax: number;
  allowFly: boolean;
};

/** Faixas canônicas base (espelho do seed `phb_wild_shape_cr_band`). */
export const WILD_SHAPE_BASE_CR_BANDS: readonly WildShapeCrBand[] = [
  { minLevel: 2, crMax: 0.25, allowFly: false },
  { minLevel: 4, crMax: 0.5, allowFly: false },
  { minLevel: 8, crMax: 1, allowFly: true },
] as const;

const MOON_CIRCLE_DIVISOR = 3;
const MOON_AC_BASE = 13;

/** Parseia `challenge_rating` do catálogo (`0`, `1/8`, `1/4`, `1/2`, `1`, …). */
export function parseChallengeRating(
  raw: string | null | undefined,
): number | null {
  if (raw == null) return null;
  const s = String(raw).trim().toLowerCase();
  if (!s || s === '—' || s === '-') return null;
  if (s.includes('/')) {
    const [a, b] = s.split('/');
    const num = Number(a);
    const den = Number(b);
    if (!Number.isFinite(num) || !Number.isFinite(den) || den === 0) return null;
    return num / den;
  }
  const n = Number(s);
  return Number.isFinite(n) ? n : null;
}

export function resolveWildShapeBand(
  level: number,
  bands: readonly WildShapeCrBand[] = WILD_SHAPE_BASE_CR_BANDS,
): WildShapeCrBand | null {
  if (level < 2) return null;
  let best: WildShapeCrBand | null = null;
  for (const band of bands) {
    if (level >= band.minLevel) best = band;
  }
  return best;
}

export function maxWildShapeCr(
  level: number,
  options: { moon?: boolean; bands?: readonly WildShapeCrBand[] } = {},
): number | null {
  if (options.moon) {
    if (level < 3) return null;
    return Math.floor(level / MOON_CIRCLE_DIVISOR);
  }
  return resolveWildShapeBand(level, options.bands)?.crMax ?? null;
}

export function allowsWildShapeFly(
  level: number,
  options: { moon?: boolean; bands?: readonly WildShapeCrBand[] } = {},
): boolean {
  if (options.moon) {
    // Moon ainda respeita fly da tabela base (nv 8+).
    return resolveWildShapeBand(level, options.bands)?.allowFly ?? false;
  }
  return resolveWildShapeBand(level, options.bands)?.allowFly ?? false;
}

export function baseWildShapeTempHp(level: number): number {
  return Math.max(0, Math.floor(level));
}

/** Formas conhecidas PHB 2024: 4@2, 6@4, 8@8. */
export const WILD_SHAPE_KNOWN_FORM_BANDS: readonly {
  minLevel: number;
  formsKnown: number;
}[] = [
  { minLevel: 2, formsKnown: 4 },
  { minLevel: 4, formsKnown: 6 },
  { minLevel: 8, formsKnown: 8 },
] as const;

export function maxWildShapeKnownForms(level: number): number {
  if (level < 2) return 0;
  let best = 0;
  for (const band of WILD_SHAPE_KNOWN_FORM_BANDS) {
    if (level >= band.minLevel) best = band.formsKnown;
  }
  return best;
}

export function moonWildShapeArmorClassFloor(wisdomModifier: number): number {
  return MOON_AC_BASE + wisdomModifier;
}

export function isBeastEligibleForWildShape(input: {
  creatureType: string | null | undefined;
  challengeRating: string | null | undefined;
  hasFlySpeed: boolean;
  level: number;
  moon?: boolean;
  bands?: readonly WildShapeCrBand[];
}): boolean {
  const type = (input.creatureType ?? '').trim().toLowerCase();
  if (type !== 'beast') return false;
  const cr = parseChallengeRating(input.challengeRating);
  if (cr == null) return false;
  const max = maxWildShapeCr(input.level, {
    moon: input.moon,
    bands: input.bands,
  });
  if (max == null || cr > max) return false;
  if (input.hasFlySpeed && !allowsWildShapeFly(input.level, {
    moon: input.moon,
    bands: input.bands,
  })) {
    return false;
  }
  return true;
}
