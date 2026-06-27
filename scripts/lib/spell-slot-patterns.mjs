/**
 * Padrões PHB de espelhos de magia — full / half / pact.
 * Fonte única para o catálogo SQL (evita JSON repetido por classe).
 */

function slotRows(...values) {
  const rows = [];
  for (let i = 0; i < values.length; i++) {
    const count = values[i];
    if (count != null && count !== 0) rows.push({ circle: i + 1, slotCount: count });
  }
  return rows;
}

/** Tabela de conjurador pleno (Bardo, Clérigo, Druida, Feiticeiro, Mago). */
const FULL_BY_LEVEL = [
  slotRows(2),
  slotRows(3),
  slotRows(4, 2),
  slotRows(4, 3),
  slotRows(4, 3, 2),
  slotRows(4, 3, 3),
  slotRows(4, 3, 3, 1),
  slotRows(4, 3, 3, 2),
  slotRows(4, 3, 3, 3, 1),
  slotRows(4, 3, 3, 3, 2),
  slotRows(4, 3, 3, 3, 2, 1),
  slotRows(4, 3, 3, 3, 2, 1),
  slotRows(4, 3, 3, 3, 2, 1, 1),
  slotRows(4, 3, 3, 3, 2, 1, 1),
  slotRows(4, 3, 3, 3, 2, 1, 1, 1),
  slotRows(4, 3, 3, 3, 2, 1, 1, 1),
  slotRows(4, 3, 3, 3, 2, 1, 1, 1, 1),
  slotRows(4, 3, 3, 3, 3, 1, 1, 1, 1),
  slotRows(4, 3, 3, 3, 3, 2, 1, 1, 1),
  slotRows(4, 3, 3, 3, 3, 2, 2, 1, 1),
];

/** Conjurador parcial (Paladino, Guardião). */
const HALF_BY_LEVEL = [
  slotRows(2),
  slotRows(2),
  slotRows(3),
  slotRows(3),
  slotRows(4, 2),
  slotRows(4, 2),
  slotRows(4, 3),
  slotRows(4, 3),
  slotRows(4, 3, 2),
  slotRows(4, 3, 2),
  slotRows(4, 3, 3),
  slotRows(4, 3, 3),
  slotRows(4, 3, 3, 1),
  slotRows(4, 3, 3, 1),
  slotRows(4, 3, 3, 2),
  slotRows(4, 3, 3, 2),
  slotRows(4, 3, 3, 3, 1),
  slotRows(4, 3, 3, 3, 1),
  slotRows(4, 3, 3, 3, 2),
  slotRows(4, 3, 3, 3, 2),
];

/** Magia de pacto (Bruxo): um círculo efetivo por nível. */
const PACT_BY_LEVEL = [
  [{ circle: 1, slotCount: 1 }],
  [{ circle: 1, slotCount: 2 }],
  [{ circle: 2, slotCount: 2 }],
  [{ circle: 2, slotCount: 2 }],
  [{ circle: 3, slotCount: 2 }],
  [{ circle: 3, slotCount: 2 }],
  [{ circle: 4, slotCount: 2 }],
  [{ circle: 4, slotCount: 2 }],
  [{ circle: 5, slotCount: 2 }],
  [{ circle: 5, slotCount: 2 }],
  [{ circle: 5, slotCount: 3 }],
  [{ circle: 5, slotCount: 3 }],
  [{ circle: 5, slotCount: 3 }],
  [{ circle: 5, slotCount: 3 }],
  [{ circle: 5, slotCount: 3 }],
  [{ circle: 5, slotCount: 3 }],
  [{ circle: 5, slotCount: 4 }],
  [{ circle: 5, slotCount: 4 }],
  [{ circle: 5, slotCount: 4 }],
  [{ circle: 5, slotCount: 4 }],
];

export const SPELL_SLOT_PATTERNS = [
  {
    slug: "full",
    name: "Conjurador pleno",
    description: "Tabela de espelhos de magia plena (PHB 2024).",
    byLevel: FULL_BY_LEVEL,
  },
  {
    slug: "half",
    name: "Conjurador parcial",
    description: "Meio conjurador — Paladino, Guardião.",
    byLevel: HALF_BY_LEVEL,
  },
  {
    slug: "pact",
    name: "Magia de pacto",
    description: "Espelhos de pacto do Bruxo (nível do espelho + quantidade).",
    byLevel: PACT_BY_LEVEL,
  },
];

export const CLASS_SPELL_SLOT_PATTERN = {
  bard: "full",
  cleric: "full",
  druid: "full",
  sorcerer: "full",
  wizard: "full",
  paladin: "half",
  ranger: "half",
  warlock: "pact",
};

export function buildSpellSlotByLevelRows() {
  const rows = [];
  for (const pattern of SPELL_SLOT_PATTERNS) {
    for (let level = 1; level <= 20; level++) {
      for (const { circle, slotCount } of pattern.byLevel[level - 1]) {
        rows.push({
          patternSlug: pattern.slug,
          level,
          circle,
          slotCount,
        });
      }
    }
  }
  return rows;
}

/** Resolve espelhos para validação (substitui leitura direta do JSON por classe). */
export function spellSlotsForPattern(patternSlug, level) {
  const pattern = SPELL_SLOT_PATTERNS.find((p) => p.slug === patternSlug);
  if (!pattern || level < 1 || level > 20) return null;
  const rows = pattern.byLevel[level - 1];
  const out = {};
  for (const { circle, slotCount } of rows) {
    out[String(circle)] = slotCount;
  }
  return Object.keys(out).length ? out : null;
}
