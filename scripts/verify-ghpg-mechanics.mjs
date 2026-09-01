/**
 * Valida JSONs extraídos do GHPG (contagens e cobertura de action economy).
 * Uso: node scripts/verify-ghpg-mechanics.mjs
 */
import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';

const EXPECTED = {
  backgrounds: { min: 25, path: extracts.grimHollow.cap3Backgrounds },
  feats: { min: 40, path: extracts.grimHollow.cap4Feats },
  transformations: { min: 12, path: extracts.grimHollow.cap6Transformations },
};

function loadJson(filePath) {
  if (!fs.existsSync(filePath)) {
    console.error(`✗ Arquivo ausente: ${filePath}`);
    return null;
  }
  return JSON.parse(fs.readFileSync(filePath, 'utf8'));
}

function logActionEconomy(label, items) {
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

const cap3 = loadJson(EXPECTED.backgrounds.path);
if (cap3) {
  const count = cap3.backgroundCount ?? cap3.backgrounds?.length ?? 0;
  const pass = count >= EXPECTED.backgrounds.min;
  ok &&= pass;
  console.log(`${pass ? '✓' : '✗'} backgrounds: ${count} (mín. ${EXPECTED.backgrounds.min})`);
  logActionEconomy('backgrounds', cap3.backgrounds ?? []);

  const missingFeat = (cap3.backgrounds ?? []).filter((b) => !b.feat?.slug);
  const missingSkills = (cap3.backgrounds ?? []).filter((b) => (b.skillSlugs?.length ?? 0) < 2);
  const unmappedTools = (cap3.backgrounds ?? []).filter(
    (b) => b.toolProficiency?.kind === 'fixed' && !b.toolProficiency?.itemSlug,
  );
  const unmappedItems = (cap3.backgrounds ?? [])
    .flatMap((b) => b.equipment?.optionA?.items ?? [])
    .filter((i) => !i.itemSlug && !i.choiceText);
  if (missingFeat.length) console.warn('  backgrounds sem feat:', missingFeat.map((b) => b.slug));
  if (missingSkills.length) console.warn('  backgrounds com <2 skills:', missingSkills.map((b) => b.slug));
  if (unmappedTools.length) console.warn('  tool proficiencies sem itemSlug:', unmappedTools.length);
  if (unmappedItems.length) {
    console.warn('  itens de equipamento sem slug (blockers):');
    for (const i of unmappedItems) console.warn(`    - ${i.name}`);
  }
}

const cap4 = loadJson(EXPECTED.feats.path);
if (cap4) {
  const count = cap4.featCount ?? cap4.feats?.length ?? 0;
  const pass = count >= EXPECTED.feats.min;
  ok &&= pass;
  console.log(`${pass ? '✓' : '✗'} feats: ${count} (mín. ${EXPECTED.feats.min})`, cap4.byCategory);
  logActionEconomy('feats', cap4.feats ?? []);
  const noBenefits = (cap4.feats ?? []).filter((f) => !f.benefits?.length);
  if (noBenefits.length) console.warn('  feats sem benefícios:', noBenefits.map((f) => f.slug));
}

const cap6 = loadJson(EXPECTED.transformations.path);
if (cap6) {
  const count = cap6.transformationCount ?? cap6.transformations?.length ?? 0;
  const pass = count >= EXPECTED.transformations.min;
  ok &&= pass;
  console.log(`${pass ? '✓' : '✗'} transformations: ${count} (mín. ${EXPECTED.transformations.min})`);
  logActionEconomy('transformations', cap6.transformations ?? []);
  const stageCounts = (cap6.transformations ?? []).map((t) => t.stages?.length ?? 0);
  if (stageCounts.length) {
    console.log(`  estágios por tipo: min=${Math.min(...stageCounts)} max=${Math.max(...stageCounts)}`);
  }
}

process.exit(ok ? 0 : 1);
