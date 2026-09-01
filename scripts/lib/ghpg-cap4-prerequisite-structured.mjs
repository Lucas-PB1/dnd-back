/**
 * Pré-requisitos estruturados dos talentos GH Cap. 4 (para phb_feat_requirement).
 * @typedef {{ minimumLevel: number | null, requiresSpellcasting: boolean, requiresFightingStyle: boolean, abilityPrerequisites: { abilitySlug: string, minimumScore: number }[], requiredFeatSlugs: string[], requiredBackgroundSlug: string | null }} StructuredFeatRequirement
 */

const ABILITY_PATTERNS = [
  { pattern: /\bStrength\b/i, slug: 'forca' },
  { pattern: /\bDexterity\b/i, slug: 'destreza' },
  { pattern: /\bConstitution\b/i, slug: 'constituicao' },
  { pattern: /\bIntelligence\b/i, slug: 'inteligencia' },
  { pattern: /\bWisdom\b/i, slug: 'sabedoria' },
  { pattern: /\bCharisma\b/i, slug: 'carisma' },
];

/** @type {Record<string, string>} */
const FEAT_NAME_TO_SLUG = {
  'Triage Expert Feat': 'triage-expert',
  'Shadowsteel Adept Feat': 'shadowsteel-adept',
};

/** @type {Record<string, string>} */
const TRANSFORMATION_TO_SLUG = {
  'Lich Transformation': 'gh-transformation-lich',
  'Vampire Transformation': 'gh-transformation-vampire',
  'Specter Transformation': 'gh-transformation-specter',
  'Aberrant Horror Transformation': 'gh-transformation-aberrant-horror',
  'Fey Transformation': 'gh-transformation-fey',
  'Fiend Transformation': 'gh-transformation-fiend',
  'Primordial Transformation': 'gh-transformation-primordial',
  'Seraph Transformation': 'gh-transformation-seraph',
  'Shadowsteel Ghoul Transformation': 'gh-transformation-shadowsteel-ghoul',
  'Lycanthrope Transformation': 'gh-transformation-lycanthrope',
};

/** @type {Record<string, string>} */
const BACKGROUND_NAME_TO_SLUG = {
  'Syndicate Smuggler background': 'gh-syndicate-smuggler',
};

/**
 * @param {string | null | undefined} prerequisite
 * @param {string} category
 * @returns {StructuredFeatRequirement | null}
 */
export function parseStructuredFeatPrerequisite(prerequisite, category) {
  if (!prerequisite) {
    if (category === 'fighting-style') {
      return emptyRequirement({ requiresFightingStyle: true });
    }
    return null;
  }

  const req = emptyRequirement({
    requiresFightingStyle: /Fighting Style Feature/i.test(prerequisite),
  });

  const levelMatch = prerequisite.match(/Level\s+(\d+)\+/i);
  if (levelMatch) {
    req.minimumLevel = Number(levelMatch[1]);
  }

  if (/Spellcasting or Pact Magic Feature/i.test(prerequisite)) {
    req.requiresSpellcasting = true;
  }

  for (const { pattern, slug } of ABILITY_PATTERNS) {
    if (pattern.test(prerequisite)) {
      req.abilityPrerequisites.push({ abilitySlug: slug, minimumScore: 13 });
    }
  }

  for (const [label, slug] of Object.entries(FEAT_NAME_TO_SLUG)) {
    if (prerequisite.includes(label)) {
      req.requiredFeatSlugs.push(slug);
    }
  }

  for (const [label, slug] of Object.entries(TRANSFORMATION_TO_SLUG)) {
    if (prerequisite.includes(label)) {
      req.requiredFeatSlugs.push(slug);
    }
  }

  for (const [label, slug] of Object.entries(BACKGROUND_NAME_TO_SLUG)) {
    if (prerequisite.includes(label)) {
      req.requiredBackgroundSlug = slug;
    }
  }

  return hasStructuredData(req) ? req : null;
}

/**
 * @param {import('../docs/source/extracts/grim-hollow/cap4-feats.json')['feats'][0]} feat
 * @returns {StructuredFeatRequirement | null}
 */
export function resolveFeatStructuredRequirement(feat) {
  const parsed = parseStructuredFeatPrerequisite(feat.prerequisite, feat.category);
  if (parsed) return parsed;
  if (feat.category === 'fighting-style') {
    return emptyRequirement({ requiresFightingStyle: true });
  }
  return null;
}

/** AWP vive em J004, não no extract Cap. 4. */
export function advancedWeaponProficiencyRequirement() {
  return emptyRequirement({ requiresFightingStyle: true });
}

/**
 * @param {StructuredFeatRequirement | null} req
 * @returns {boolean}
 */
export function hasStructuredData(req) {
  if (!req) return false;
  return (
    req.minimumLevel != null ||
    req.requiresSpellcasting ||
    req.requiresFightingStyle ||
    req.abilityPrerequisites.length > 0 ||
    req.requiredFeatSlugs.length > 0
  );
}

/** @param {Partial<StructuredFeatRequirement>} overrides */
function emptyRequirement(overrides = {}) {
  return {
    minimumLevel: null,
    requiresSpellcasting: false,
    requiresFightingStyle: false,
    abilityPrerequisites: [],
    requiredFeatSlugs: [],
    requiredBackgroundSlug: null,
    ...overrides,
  };
}
