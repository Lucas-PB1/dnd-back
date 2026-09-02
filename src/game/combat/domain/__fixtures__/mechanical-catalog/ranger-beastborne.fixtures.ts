/** Seeds `combat/C00*` — Beastborne aspect benefits by level. */
export const FIXTURE_BESTIAL_ASPECT_BENEFITS = [
  {
    level: 1,
    note: 'Carnificina: +2 nas jogadas de dano com armas e Ataques Desarmados.',
  },
  { level: 2, note: 'Movimento Rápido: Deslocamento +3 m.' },
  {
    level: 3,
    note: 'Frenesi Sangrento: Vantagem em ataques contra criaturas sem PV cheios.',
  },
  { level: 4, note: 'Pele Espessa: +2 CA se não empunhar Escudo.' },
  {
    level: 5,
    note: 'Retaliação: Reação para atacar corpo a corpo quem causar dano a ≤1,5 m.',
  },
] as const;
