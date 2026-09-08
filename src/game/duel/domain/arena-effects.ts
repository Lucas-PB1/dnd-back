export const DUEL_ARENA_EFFECTS = ['magical_darkness'] as const;

export type DuelArenaEffect = (typeof DUEL_ARENA_EFFECTS)[number];

/** Slug PHB PT da magia Escuridão. */
export const MAGICAL_DARKNESS_SPELL_SLUG = 'escuridao';

export const DEVIL_SIGHT_INVOCATION_SLUG = 'devil-sight';

export function hasMagicalDarkness(
  effects: readonly string[] | null | undefined,
): boolean {
  return (effects ?? []).includes('magical_darkness');
}

export function setMagicalDarkness(
  effects: readonly string[] | null | undefined,
): DuelArenaEffect[] {
  const next = new Set(effects ?? []);
  next.add('magical_darkness');
  return [...next] as DuelArenaEffect[];
}

export function clearMagicalDarkness(
  effects: readonly string[] | null | undefined,
): DuelArenaEffect[] {
  return (effects ?? []).filter(
    (effect) => effect !== 'magical_darkness',
  ) as DuelArenaEffect[];
}
