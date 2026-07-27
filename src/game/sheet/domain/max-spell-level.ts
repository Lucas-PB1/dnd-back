/**
 * Highest spell circle with at least one slot (PHB slot tables).
 * Source of truth for what a character may prepare from the class list.
 */
export function maxSpellLevelFromSlots(
  slots: Record<string, number> | null | undefined,
): number {
  if (!slots) return 0;
  let max = 0;
  for (const [circle, count] of Object.entries(slots)) {
    if (count <= 0) continue;
    const level = Number(circle);
    if (Number.isFinite(level) && level > max) max = level;
  }
  return max;
}
