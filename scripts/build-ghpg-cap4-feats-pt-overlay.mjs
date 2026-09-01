/**
 * Gera overlay PT editorial para Cap. 4 GH (41 feats).
 *
 * Uso: node scripts/build-ghpg-cap4-feats-pt-overlay.mjs
 */
import fs from 'fs';
import path from 'path';

import { extracts } from './lib/docs-source.mjs';
import {
  CAP4_BENEFIT_NAMES_PT,
  CAP4_FEAT_NAMES_PT,
} from './lib/ghpg-cap4-feat-names-pt.mjs';
import { translateFeatPrerequisite } from './lib/ghpg-cap4-prerequisite-pt.mjs';
import {
  translateCap4FeatBody,
  translateCap4FeatIntro,
} from './lib/ghpg-cap4-feat-prose.mjs';
import {
  applyGhpgGlossary,
} from './lib/ghpg-mechanical-glossary.mjs';
import {
  BENEFIT_DESCRIPTION_OVERRIDES,
  INTRO_OVERRIDES,
} from './lib/ghpg-cap4-feat-overrides-pt.mjs';

const enPath = extracts.grimHollow.cap4Feats;
const outPath = extracts.grimHollow.cap4FeatsPt;

function translateBenefitName(name) {
  return CAP4_BENEFIT_NAMES_PT[name] ?? applyGhpgGlossary(name);
}

function benefitOverrideKey(slug, benefitName) {
  return `${slug}:${benefitName}`;
}

if (!fs.existsSync(enPath)) {
  console.error(`Extract EN ausente: ${enPath}`);
  console.error('Rode: node scripts/extract-ghpg-cap4.mjs');
  process.exit(1);
}

const en = JSON.parse(fs.readFileSync(enPath, 'utf8'));
const overlay = {
  generatedAt: new Date().toISOString(),
  source: enPath.replace(/\\/g, '/'),
  feats: {},
};

for (const feat of en.feats ?? []) {
  const introKey = feat.slug;
  overlay.feats[feat.slug] = {
    namePt: CAP4_FEAT_NAMES_PT[feat.slug] ?? applyGhpgGlossary(feat.nameEn),
    prerequisitePt: translateFeatPrerequisite(feat.prerequisite),
    introPt: INTRO_OVERRIDES[introKey] ?? (feat.intro ? translateCap4FeatIntro(feat.intro) : null),
    benefits: feat.benefits.map((benefit) => {
      const key = benefitOverrideKey(feat.slug, benefit.name);
      return {
        namePt: translateBenefitName(benefit.name),
        descriptionPt:
          BENEFIT_DESCRIPTION_OVERRIDES[key] ?? translateCap4FeatBody(benefit.description),
      };
    }),
  };
}

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, `${JSON.stringify(overlay, null, 2)}\n`, 'utf8');
console.log(`wrote ${outPath.replace(/\\/g, '/')} — ${Object.keys(overlay.feats).length} feats`);
