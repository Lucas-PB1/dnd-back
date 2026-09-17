/** Punição Mística (Eldritch Smite): +1d8 Energético por círculo do slot de Pacto. */
export const ELDRITCH_SMITE_INVOCATION_SLUG = 'eldritch-smite';

export function eldritchSmiteDice(slotLevel: number): string {
  const n = Math.max(1, Math.floor(slotLevel));
  return `${n}d8`;
}

export function canUseEldritchSmite(input: {
  classSlug: string | null | undefined;
  level: number;
  invocationSlugs: readonly string[];
}): boolean {
  if (input.classSlug !== 'warlock') return false;
  if (input.level < 5) return false;
  return input.invocationSlugs.includes(ELDRITCH_SMITE_INVOCATION_SLUG);
}
