/** Predicados puros sobre níveis ASI/talento vindos do catálogo (`phb_class_progression.asi_or_feat`). */

export function isAsiOrFeatLevel(
  asiFeatLevels: readonly number[],
  level: number,
): boolean {
  return asiFeatLevels.includes(level);
}

export function countAsiFeatSlots(
  asiFeatLevels: readonly number[],
  level: number,
): number {
  return asiFeatLevels.filter((asiLevel) => asiLevel <= level).length;
}

export function asiFeatLevelsUpTo(
  asiFeatLevels: readonly number[],
  level: number,
): number[] {
  return asiFeatLevels.filter((asiLevel) => asiLevel <= level);
}
