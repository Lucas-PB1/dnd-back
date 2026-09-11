export function isDruidClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'druid';
}

export function wildShapeMaxUses(level: number): number {
  if (level < 2) return 0;
  if (level >= 17) return 4;
  if (level >= 6) return 3;
  return 2;
}

export function moonWildShapeTempHp(level: number): number {
  return 3 * level;
}

/** Auxílio da Terra: 2d6 → 3d6@10 → 4d6@14. */
export function landAidDice(level: number): number {
  if (level >= 14) return 4;
  if (level >= 10) return 3;
  return 2;
}

/** Forma Estelar Arquiro/Cálice: 1d8 → 2d8@10. */
export function starryFormDice(level: number): string {
  return level >= 10 ? '2d8' : '1d8';
}

/** Ira do Mar: 1,5 m → 3 m@6. */
export function wrathOfTheSeaRadiusMeters(level: number): number {
  return level >= 6 ? 3 : 1.5;
}
