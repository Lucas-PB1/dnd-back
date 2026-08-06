export type PrecautionSpell = { slug: string; name: string };

export function findPrecautionSpell(
  catalog: readonly PrecautionSpell[],
  spellSlug: string,
): PrecautionSpell | undefined {
  return catalog.find((spell) => spell.slug === spellSlug);
}
