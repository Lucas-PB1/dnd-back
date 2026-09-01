/**
 * Auditoria Cap. 6 — extract e seeds de transformações.
 * Uso: node scripts/audit-ghpg-cap6.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';
import { CAP6_BENEFIT_SEEDS } from './generate-ghpg-cap6-seeds.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap6Path = extracts.grimHollow.cap6Transformations;
const seedsDir = path.join(apiRoot, 'database/seeds/grim-hollow');
const outPath = path.join(
  apiRoot,
  'docs/source/extracts/grim-hollow/_audit-cap6-coverage.json',
);

const cap6 = JSON.parse(fs.readFileSync(cap6Path, 'utf8'));

const issues = [];
const rows = [];

for (const t of cap6.transformations) {
  let emptyListRefs = 0;
  let flavorLeaks = 0;
  let orphanAdvancement = 0;
  let boonCount = 0;

  for (const s of t.stages) {
    if (/^AchievingANewStage/i.test(s.anchorId)) orphanAdvancement += 1;
    for (const entry of [...s.boons, ...s.flaws]) {
      boonCount += 1;
      const d = entry.description || '';
      if (
        (/following (effects|situations|additional effects)/i.test(d) ||
          /Choose one of the following effects/i.test(d)) &&
        !d.includes('•') &&
        !/\n[A-Z][a-z]+ [A-Z]/.test(d)
      ) {
        emptyListRefs += 1;
        issues.push({
          slug: t.slug,
          anchorId: entry.anchorId,
          kind: 'empty_list',
        });
      }
      if (/He faded away/i.test(d)) {
        flavorLeaks += 1;
        issues.push({
          slug: t.slug,
          anchorId: entry.anchorId,
          kind: 'flavor_leak',
        });
      }
    }
  }

  const seedMeta = CAP6_BENEFIT_SEEDS.find((m) => m.slug === t.slug);

  rows.push({
    slug: t.slug,
    namePt: t.namePt,
    stages: t.stages.filter((s) => !/^AchievingANewStage/i.test(s.anchorId))
      .length,
    boons: t.boonCount,
    flaws: t.flawCount,
    appendices: t.appendices?.length ?? 0,
    emptyListRefs,
    flavorLeaks,
    orphanAdvancement,
    seedFile: seedMeta?.file ?? null,
  });
}

const report = {
  extractedAt: cap6.extractedAt,
  transformationCount: cap6.transformationCount,
  issueCount: issues.length,
  issues,
  rows,
};

fs.writeFileSync(outPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
console.log(`Wrote ${outPath}`);
console.log(`Issues: ${issues.length}`);
for (const row of rows) {
  console.log(
    `  ${row.slug}: ${row.stages} stages, ${row.appendices} appendices, lists vazias=${row.emptyListRefs}, flavor=${row.flavorLeaks}`,
  );
}
