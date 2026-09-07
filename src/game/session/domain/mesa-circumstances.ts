/** Circunstâncias de mesa (neve/água/frio) — toggle na ficha, não combate real. */
export const MESA_CIRCUMSTANCE_TAGS = [
  'snow_ice',
  'in_water',
  'extreme_cold',
] as const;

export type MesaCircumstanceTag = (typeof MESA_CIRCUMSTANCE_TAGS)[number];

export function isMesaCircumstanceTag(
  value: string,
): value is MesaCircumstanceTag {
  return (MESA_CIRCUMSTANCE_TAGS as readonly string[]).includes(value);
}

export function normalizeMesaCircumstances(
  values: readonly string[] | null | undefined,
): MesaCircumstanceTag[] {
  if (!values?.length) return [];
  const seen = new Set<MesaCircumstanceTag>();
  for (const raw of values) {
    const tag = raw.trim();
    if (isMesaCircumstanceTag(tag)) seen.add(tag);
  }
  return [...seen];
}

export function toggleMesaCircumstance(
  current: readonly string[] | null | undefined,
  tag: MesaCircumstanceTag,
  enabled?: boolean,
): MesaCircumstanceTag[] {
  const set = new Set(normalizeMesaCircumstances(current));
  const next = enabled ?? !set.has(tag);
  if (next) set.add(tag);
  else set.delete(tag);
  return [...set];
}

export const SNOWRUNNER_TOGGLE_ACTION = 'snowrunner-toggle-snow-ice' as const;
export const COLD_PLUNGE_WATER_ACTION = 'cold-plunge-toggle-in-water' as const;
export const COLD_PLUNGE_COLD_ACTION =
  'cold-plunge-toggle-extreme-cold' as const;
