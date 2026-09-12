

const RISK_DIE_FACES_BY_LEVEL: ReadonlyArray<{
  minLevel: number;
  maxLevel: number;
  faces: number;
}> = [
  { minLevel: 2, maxLevel: 9, faces: 8 },
  { minLevel: 10, maxLevel: 17, faces: 10 },
  { minLevel: 18, maxLevel: 20, faces: 12 },
];

export function riskDieFaces(level: number): number | null {
  if (!Number.isInteger(level) || level < 2 || level > 20) return null;
  for (const row of RISK_DIE_FACES_BY_LEVEL) {
    if (level >= row.minLevel && level <= row.maxLevel) return row.faces;
  }
  return null;
}

export function riskDieLabel(level: number): string | null {
  const faces = riskDieFaces(level);
  return faces == null ? null : `d${faces}`;
}
