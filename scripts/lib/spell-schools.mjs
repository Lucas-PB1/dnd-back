/** Escolas de magia PHB 2024 (8 escolas fixas). */

export const SPELL_SCHOOLS = [
  { slug: "abjuracao", name: "Abjuração", sortOrder: 1 },
  { slug: "adivinhacao", name: "Adivinhação", sortOrder: 2 },
  { slug: "encantamento", name: "Encantamento", sortOrder: 3 },
  { slug: "evocacao", name: "Evocação", sortOrder: 4 },
  { slug: "ilusao", name: "Ilusão", sortOrder: 5 },
  { slug: "invocacao", name: "Invocação", sortOrder: 6 },
  { slug: "necromancia", name: "Necromancia", sortOrder: 7 },
  { slug: "transmutacao", name: "Transmutação", sortOrder: 8 },
];

export const SPELL_SCHOOL_SLUG_BY_NAME = Object.fromEntries(
  SPELL_SCHOOLS.map((s) => [s.name, s.slug])
);
