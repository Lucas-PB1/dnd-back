#!/usr/bin/env node
/**
 * Valida seeds Cap. 1 GH (heranças + traços modulares).
 * Uso: node scripts/verify-ghpg-cap1-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';

import { canonicalAnchorId, findTraitByAnchor } from './lib/ghpg-cap1-anchor.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const seedsDir = path.join(apiRoot, 'database/seeds/grim-hollow');

const cap1 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap1Heritages, 'utf8'));
const ptOverlayPath = extracts.grimHollow.cap1HeritagesPt;
const ptOverlay = fs.existsSync(ptOverlayPath)
  ? JSON.parse(fs.readFileSync(ptOverlayPath, 'utf8'))
  : null;

/** @param {typeof cap1.traits[0]} trait */
function expectedBenefitImproved(trait) {
  const pt = ptOverlay?.traits?.[trait.slug];
  return pt?.benefitImproved ?? trait.benefitImproved;
}
const j037 = fs.readFileSync(path.join(seedsDir, 'J037_phb_heritage_catalog.sql'), 'utf8');
const j038 = fs.readFileSync(path.join(seedsDir, 'J038_phb_heritage_traditional.sql'), 'utf8');

let ok = 0;
function pass(msg) {
  ok += 1;
  console.log(`✓ ${msg}`);
}
function fail(msg) {
  console.error(`✗ ${msg}`);
  process.exitCode = 1;
}

const heritageSlugs = cap1.heritages.map((h) => h.slug);
for (const slug of heritageSlugs) {
  if (!j037.includes(`'${slug}'`)) fail(`J037 sem herança ${slug}`);
}
if (process.exitCode !== 1) pass(`J037: ${heritageSlugs.length} heranças`);

for (const trait of cap1.traits) {
  if (!j037.includes(`'${trait.slug}'`)) fail(`J037 sem traço ${trait.slug}`);
}
if (process.exitCode !== 1) pass(`J037: pool ${cap1.traits.length} traços`);

for (const trait of cap1.traits) {
  const improved = expectedBenefitImproved(trait);
  if (improved) {
    const needle = improved.slice(0, 30).replace(/'/g, "''");
    if (!j037.includes(needle.slice(0, 20))) {
      fail(`J037 sem benefit_improved ${trait.slug}`);
      break;
    }
  }
}
if (process.exitCode !== 1) pass('J037: benefit_improved quando aplicável');

for (const h of ['gh-dwarf', 'gh-elf']) {
  const traditional = cap1.heritages.find((row) => row.slug === h)?.traditionalTraits;
  const total =
    (traditional?.combat?.length ?? 0) +
    (traditional?.exploration?.length ?? 0) +
    (traditional?.roleplaying?.length ?? 0);
  if (total === 0) fail(`${h}: traditionalTraits vazio no extract`);
  else pass(`${h}: ${total} traços tradicionais sugeridos`);
}

const poolSlugs = new Set(cap1.traits.map((t) => t.slug));
for (const heritage of cap1.heritages) {
  for (const key of ['combat', 'exploration', 'roleplaying']) {
    for (const tr of heritage.traditionalTraits[key] ?? []) {
      const trait = findTraitByAnchor(cap1.traits, tr.anchorId);
      if (!trait) {
        fail(`${heritage.slug}: anchor ${tr.anchorId} ausente no pool`);
        break;
      }
      if (!poolSlugs.has(trait.slug)) {
        fail(`${heritage.slug}: traço tradicional ${trait.slug} fora do pool`);
      }
      if (!j038.includes(`'${trait.slug}'`)) {
        fail(`J038 sem traço tradicional ${heritage.slug}/${trait.slug}`);
      }
    }
  }
}
if (process.exitCode !== 1) pass('J038: tradicionais ⊆ pool global');

if (/150 pounds|30 feet|5 feet tall/i.test(`${j037}\n${j038}`)) {
  fail('J037/J038 ainda contém unidades imperiais');
} else pass('J037/J038 sem libras/pés óbvios');

if (j037.includes('phb_heritage_trait') && j037.includes('benefit_base')) {
  pass('J037: colunas benefit_base/benefit_improved');
} else fail('J037 sem benefit_base');

console.log(`\n${ok} verificações OK`);
