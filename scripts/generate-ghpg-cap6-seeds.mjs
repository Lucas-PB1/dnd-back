/**
 * Gera seed J019 (Transformações Grim Hollow como talentos catalogOnly).
 * Uso: node scripts/generate-ghpg-cap6-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap6Path = path.join(apiRoot, 'docs/source/ghpg-cap6-transformations-extract.json');
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');

const CITATION_CAP6 = 'grim-hollow-players-guide-2024-en:chapter-6-transformations';

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

/** @param {import('../docs/source/ghpg-cap6-transformations-extract.json')} cap6 */
function buildTransformationsSql(cap6) {
  const featRows = cap6.transformations.map(
    (t) => `(
  ${sqlLiteral(t.slug)},
  ${sqlLiteral(t.namePt)},
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlLiteral(CITATION_CAP6)})
)`,
  );

  const benefitLines = [];
  for (const t of cap6.transformations) {
    let sort = 1;
    if (t.becoming) {
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, 'Como começar', ${sqlLiteral(t.becoming)}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
    }
    for (const stage of t.stages) {
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(`Estágio ${stage.stage}`)}, ${sqlLiteral(stage.summary || stage.body.slice(0, 2000))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
      for (const boon of stage.boons) {
        benefitLines.push(
          `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(boon.name)}, ${sqlLiteral(boon.description)}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
        );
        sort += 1;
      }
      for (const flaw of stage.flaws) {
        benefitLines.push(
          `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(flaw.name)}, ${sqlLiteral(flaw.description)}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
        );
        sort += 1;
      }
    }
  }

  return `-- Grim Hollow Cap. 6 — transformações (catálogo; categoria gh-transformation)

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
${featRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

${benefitLines.join('\n\n')}
`;
}

const cap6 = JSON.parse(fs.readFileSync(cap6Path, 'utf8'));
fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'J019_phb_feat_ghpg_transformations.sql'), buildTransformationsSql(cap6), 'utf8');
console.log(`J019 gerado — ${cap6.transformationCount} transformações`);
