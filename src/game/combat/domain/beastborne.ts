const BESTIAL_ASPECT_MIN = 0;
const BESTIAL_ASPECT_MAX = 5;

const BESTIAL_ASPECT_BENEFITS: ReadonlyArray<{ level: number; note: string }> = [
  {
    level: 1,
    note: 'Carnificina: +2 nas jogadas de dano com armas e Ataques Desarmados.',
  },
  {
    level: 2,
    note: 'Movimento Rápido: Deslocamento +3 m.',
  },
  {
    level: 3,
    note: 'Frenesi Sangrento: Vantagem em ataques contra criaturas sem PV cheios.',
  },
  {
    level: 4,
    note: 'Pele Espessa: +2 CA se não empunhar Escudo.',
  },
  {
    level: 5,
    note: 'Retaliação: Reação para atacar corpo a corpo quem causar dano a ≤1,5 m.',
  },
];

export function clampBestialAspectLevel(n: number): number {
  if (!Number.isFinite(n)) return BESTIAL_ASPECT_MIN;
  return Math.min(
    BESTIAL_ASPECT_MAX,
    Math.max(BESTIAL_ASPECT_MIN, Math.trunc(n)),
  );
}

/** Notas de benefícios acumulados até o nível informado (para UI). */
export function bestialAspectBenefits(level: number): string[] {
  const clamped = clampBestialAspectLevel(level);
  return BESTIAL_ASPECT_BENEFITS.filter((entry) => entry.level <= clamped).map(
    (entry) => entry.note,
  );
}
