/**
 * Valida JSONs extraídos do GHPG (contagens e cobertura de action economy).
 * Uso: node scripts/verify-ghpg-mechanics.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');

const EXPECTED = {
  backgrounds: { min: 25, file: 'ghpg-cap3-backgrounds-extract.json' },
  feats: { min: 40, file: 'ghpg-cap4-feats-extract.json' },
  transformations: { min: 12, file: 'ghpg-cap6-transformations-extract.json' },
};

function loadJson(name) {
  const p = path.join(apiRoot, 'docs/source', name);
  if (!fs.existsSync(p)) {
    console.error(`✗ Arquivo ausente: ${p}`);
    return null;
  }
  return JSON.parse(fs.readFileSync(p, 'utf8'));
}

function logActionEconomy(label, items, getText) {
  const withEconomy = items.filter((item) => (item.actionEconomy?.length ?? 0) > 0);
  const buckets = {};
  for (const item of items) {
    for (const b of item.actionEconomy ?? []) {
      buckets[b] = (buckets[b] ?? 0) + 1;
    }
  }
  console.log(`  ${label}: ${withEconomy.length}/${items.length} com actionEconomy`, buckets);
}

let ok = true;

const cap3 = loadJson(EXPECTED.backgrounds.file);
if (cap3) {
  const pass = cap3.backgroundCount >= EXPECTED.backgrounds.min;
  ok &&= pass;
  console.log(`${pass ? '✓' : '✗'} backgrounds: ${cap3.backgroundCount} (mín. ${EXPECTED.backgrounds.min})`);
  logActionEconomy('backgrounds', cap3.backgrounds, (b) => b.description);

  const missingFeat = cap3.backgrounds.filter((b) => !b.feat?.slug);
  const missingSkills = cap3.backgrounds.filter((b) => b.skillSlugs.length < 2);
  const unmappedTools = cap3.backgrounds.filter((b) => b.toolProficiency?.kind === 'fixed' && !b.toolProficiency?.itemSlug);
  const unmappedItems = cap3.backgrounds.flatMap((b) => b.equipment?.optionA?.items ?? []).filter((i) => !i.itemSlug && !i.choiceText);
  if (missingFeat.length) console.warn('  backgrounds sem feat:', missingFeat.map((b) => b.slug));
  if (missingSkills.length) console.warn('  backgrounds com <2 skills:', missingSkills.map((b) => b.slug));
  if (unmappedTools.length) console.warn('  tool proficiencies sem itemSlug:', unmappedTools.length);
  if (unmappedItems.length) {
    console.warn('  itens de equipamento sem slug (blockers):');
    for (const i of unmappedItems) console.warn(`    - ${i.name}`);
  }
}

const cap4 = loadJson(EXPECTED.feats.file);
if (cap4) {
  const pass = cap4.featCount >= EXPECTED.feats.min;
  ok &&= pass;
  console.log(`${pass ? '✓' : '✗'} feats: ${cap4.featCount} (mín. ${EXPECTED.feats.min})`, cap4.byCategory);
  logActionEconomy('feats', cap4.feats, (f) => f.description);
  const noBenefits = cap4.feats.filter((f) => !f.benefits.length);
  if (noBenefits.length) console.warn('  feats sem benefícios:', noBenefits.map((f) => f.slug));
}

const cap6 = loadJson(EXPECTED.transformations.file);
if (cap6) {
  const pass = cap6.transformationCount >= EXPECTED.transformations.min;
  ok &&= pass;
  console.log(`${pass ? '✓' : '✗'} transformations: ${cap6.transformationCount} (mín. ${EXPECTED.transformations.min})`);
  logActionEconomy('transformations', cap6.transformations, (t) => t.becoming);
  const stageCounts = cap6.transformations.map((t) => t.stages.length);
  console.log(`  estágios por tipo: min=${Math.min(...stageCounts)} max=${Math.max(...stageCounts)}`);
}

process.exit(ok ? 0 : 1);
