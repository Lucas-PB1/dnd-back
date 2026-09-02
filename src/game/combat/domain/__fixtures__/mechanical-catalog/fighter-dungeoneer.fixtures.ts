import type { PrecautionSpell } from '../../fighter/dungeoneer-catalog';

/** Seeds `combat/C00*` — Dungeoneer slayer labels. */
export const FIXTURE_DUNGEONEER_SLAYER_LABELS = [
  'Aberração',
  'Dragão',
  'Feérico',
  'Corruptor',
  'Monstruosidade',
  'Gosma',
  'Morto-vivo',
] as const;

/** Seeds `combat/C00*` — Dungeoneer precaution spells. */
export const FIXTURE_DUNGEONEER_PRECAUTION_SPELLS: readonly PrecautionSpell[] = [
  { slug: 'alarme', name: 'Alarme' },
  { slug: 'compreender-idiomas', name: 'Compreender Idiomas' },
  { slug: 'detectar-magia', name: 'Detectar Magia' },
  { slug: 'detectar-veneno-e-doenca', name: 'Detectar Veneno e Doença' },
  { slug: 'encontrar-armadilhas', name: 'Encontrar Armadilhas' },
  { slug: 'identificar', name: 'Identificar' },
  {
    slug: 'purificar-alimentos-e-bebidas',
    name: 'Purificar Alimentos e Bebidas',
  },
];
