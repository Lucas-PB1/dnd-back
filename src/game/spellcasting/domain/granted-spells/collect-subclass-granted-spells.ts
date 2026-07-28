import { SubclassGrantedSpellRow } from './types';

export function collectSubclassGrantedSpellSlugs(
  level: number,
  rows: readonly SubclassGrantedSpellRow[],
): Set<string> {
  const slugs = new Set<string>();
  for (const row of rows) {
    if (row.unlockLevel <= level) slugs.add(row.spellSlug);
  }
  return slugs;
}
