/**
 * Gera overlay PT para Cap. 1 GH (heranças + traços modulares).
 *
 * Uso: node scripts/build-ghpg-cap1-pt-overlay.mjs
 */
import fs from 'fs';

import { HERITAGE_FIELDS_PT } from './lib/ghpg-cap1-heritage-pt.mjs';
import { HERITAGE_LORE_PT } from './lib/ghpg-cap1-heritage-lore-pt.mjs';
import {
  CAP1_BASE_TRAIT_NAMES_PT,
  CAP1_TRAIT_NAMES_PT,
} from './lib/ghpg-cap1-names-pt.mjs';
import { CAP1_TRAIT_BENEFITS_PT } from './lib/ghpg-cap1-trait-benefits-pt.mjs';
import { translateGhpgBody } from './lib/ghpg-mechanical-glossary.mjs';
import {
  applyModularTraitRawPatterns,
  translateGhpgModularTrait,
  translateSkillNames,
} from './lib/ghpg-modular-trait-patterns.mjs';
import { extracts } from './lib/docs-source.mjs';

const extractPath = extracts.grimHollow.cap1Heritages;
const outPath = extracts.grimHollow.cap1HeritagesPt;

const CATEGORY_PT = {
  combat: 'Combate',
  exploration: 'Exploração',
  roleplaying: 'Interpretação',
};

/** @param {string} name */
function resolveBaseTraitName(name) {
  return CAP1_BASE_TRAIT_NAMES_PT[name] ?? name;
}

/** @param {import('../docs/source/extracts/grim-hollow/cap1-heritages.json').traits[0]} trait */
function resolveTraitName(trait) {
  return CAP1_TRAIT_NAMES_PT[trait.slug] ?? translateGhpgBody(trait.name);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));

const overlay = {
  generatedAt: new Date().toISOString(),
  sourceExtract: extractPath,
  heritages: {},
  traits: {},
};

for (const h of extract.heritages) {
  const curated = HERITAGE_FIELDS_PT[h.slug];
  overlay.heritages[h.slug] = {
    description:
      HERITAGE_LORE_PT[h.slug] ??
      curated?.description ??
      translateGhpgBody(h.description),
    size: curated?.size ?? translateGhpgBody(h.size),
    speed: curated?.speed ?? translateGhpgBody(h.speed),
    baseTraits: h.baseTraits.map((t) => ({
      name: resolveBaseTraitName(t.name),
      description: translateGhpgBody(t.description),
    })),
  };
}

function translateTraitField(text, trait) {
  const namePt = resolveTraitName(trait);
  let out = applyModularTraitRawPatterns(text);
  out = translateSkillNames(out);
  out = translateGhpgBody(out);
  out = translateGhpgModularTrait(out, {
    englishName: trait.name,
    improvedEnglishName: trait.improvedName ?? undefined,
    namePt,
  });
  return out;
}

for (const t of extract.traits) {
  const curated = CAP1_TRAIT_BENEFITS_PT[t.slug];
  const benefitBase = curated
    ? curated.benefitBase
    : translateTraitField(t.benefitBase ?? t.description, t);
  const benefitImproved = curated
    ? curated.benefitImproved
    : t.benefitImproved
      ? translateTraitField(t.benefitImproved, t)
      : null;
  const description = curated
    ? [benefitBase, benefitImproved].filter(Boolean).join('\n\n')
    : translateTraitField(t.description, t);

  overlay.traits[t.slug] = {
    name: resolveTraitName(t),
    category: CATEGORY_PT[t.category] ?? t.category,
    description,
    benefitBase,
    benefitImproved,
    improvedName: t.improvedName ? resolveTraitName(t) : null,
  };
}

fs.writeFileSync(outPath, `${JSON.stringify(overlay, null, 2)}\n`);
console.log(`Overlay PT: ${outPath.replace(/\\/g, '/')}`);
console.log(
  `  heranças=${Object.keys(overlay.heritages).length} traços=${Object.keys(overlay.traits).length}`,
);
