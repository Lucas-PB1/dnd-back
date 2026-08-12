import { UnlockLevelGrantedSpellRow } from './types';

export function collectGrantedSpellSlugsAtLevel(
  level: number,
  rows: readonly UnlockLevelGrantedSpellRow[],
): Set<string> {
  const slugs = new Set<string>();
  for (const row of rows) {
    if (row.unlockLevel <= level) slugs.add(row.spellSlug);
  }
  return slugs;
}

export const collectSubclassGrantedSpellSlugs = collectGrantedSpellSlugsAtLevel;
