/**
 * Gera seeds Cap. 6 — Transformações GH.
 * - J019: shells `phb_feat` (12 transformações)
 * - J048–J059: `phb_feat_benefit` por transformação (1 arquivo cada)
 *
 * Uso: node scripts/generate-ghpg-cap6-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';
import {
  prepareTransformationStages,
  resolveCap6AppendixDescription,
  resolveCap6AppendixTitle,
  resolveCap6Becoming,
  resolveCap6BenefitDescription,
  resolveCap6BenefitName,
  resolveCap6StageSummary,
} from './lib/ghpg-cap6-transformation-pt.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap6Path = extracts.grimHollow.cap6Transformations;
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');

const CITATION_CAP6 = 'grim-hollow-players-guide-2024-en:chapter-6-transformations';

/** @type {{ seedId: string; slug: string; file: string }[]} */
export const CAP6_BENEFIT_SEEDS = [
  {
    seedId: 'J048',
    slug: 'gh-transformation-aberrant-horror',
    file: 'J048_phb_feat_benefit_ghpg_transformation_aberrant_horror.sql',
  },
  {
    seedId: 'J049',
    slug: 'gh-transformation-fey',
    file: 'J049_phb_feat_benefit_ghpg_transformation_fey.sql',
  },
  {
    seedId: 'J050',
    slug: 'gh-transformation-fiend',
    file: 'J050_phb_feat_benefit_ghpg_transformation_fiend.sql',
  },
  {
    seedId: 'J051',
    slug: 'gh-transformation-hag',
    file: 'J051_phb_feat_benefit_ghpg_transformation_hag.sql',
  },
  {
    seedId: 'J052',
    slug: 'gh-transformation-lich',
    file: 'J052_phb_feat_benefit_ghpg_transformation_lich.sql',
  },
  {
    seedId: 'J053',
    slug: 'gh-transformation-lycanthrope',
    file: 'J053_phb_feat_benefit_ghpg_transformation_lycanthrope.sql',
  },
  {
    seedId: 'J054',
    slug: 'gh-transformation-ooze',
    file: 'J054_phb_feat_benefit_ghpg_transformation_ooze.sql',
  },
  {
    seedId: 'J055',
    slug: 'gh-transformation-primordial',
    file: 'J055_phb_feat_benefit_ghpg_transformation_primordial.sql',
  },
  {
    seedId: 'J056',
    slug: 'gh-transformation-seraph',
    file: 'J056_phb_feat_benefit_ghpg_transformation_seraph.sql',
  },
  {
    seedId: 'J057',
    slug: 'gh-transformation-shadowsteel-ghoul',
    file: 'J057_phb_feat_benefit_ghpg_transformation_shadowsteel_ghoul.sql',
  },
  {
    seedId: 'J058',
    slug: 'gh-transformation-specter',
    file: 'J058_phb_feat_benefit_ghpg_transformation_specter.sql',
  },
  {
    seedId: 'J059',
    slug: 'gh-transformation-vampire',
    file: 'J059_phb_feat_benefit_ghpg_transformation_vampire.sql',
  },
];

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

/** @param {import('../docs/source/extracts/grim-hollow/cap6-transformations.json')} cap6 */
function buildFeatShellSql(cap6) {
  const featRows = cap6.transformations.map(
    (t) => `(
  ${sqlLiteral(t.slug)},
  ${sqlLiteral(t.namePt)},
  'gh-transformation',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlLiteral(CITATION_CAP6)})
)`,
  );

  return `-- Grim Hollow Cap. 6 — transformações (shell catálogo; benefícios em J048–J059)

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
${featRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
`;
}

/** @param {import('../docs/source/extracts/grim-hollow/cap6-transformations.json')['transformations'][0]} t */
function buildTransformationBenefitLines(t) {
  const benefitLines = [];
  let sort = 1;

  if (t.becoming) {
    benefitLines.push(
      `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, 'Como começar', ${sqlLiteral(resolveCap6Becoming(t.slug, t.becoming))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
    );
    sort += 1;
  }

  for (const stage of prepareTransformationStages(t.stages)) {
    const stageTextParts = [];
    if (stage.advancementAnchorId) {
      stageTextParts.push(
        resolveCap6StageSummary(
          t.slug,
          stage.advancementAnchorId,
          stage.advancementText,
        ),
      );
    }
    stageTextParts.push(
      resolveCap6StageSummary(
        t.slug,
        stage.anchorId,
        stage.summary || stage.body.slice(0, 2000),
      ),
    );
    benefitLines.push(
      `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(`Estágio ${stage.stage}`)}, ${sqlLiteral(stageTextParts.join('\n\n'))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
    );
    sort += 1;

    for (const boon of stage.boons) {
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(resolveCap6BenefitName(t.slug, boon.anchorId, boon.name))}, ${sqlLiteral(resolveCap6BenefitDescription(t.slug, boon.anchorId, boon.description))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
    }

    for (const flaw of stage.flaws) {
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(resolveCap6BenefitName(t.slug, flaw.anchorId, flaw.name))}, ${sqlLiteral(resolveCap6BenefitDescription(t.slug, flaw.anchorId, flaw.description))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
    }
  }

  for (const appendix of t.appendices ?? []) {
    if (appendix.kind === 'gifts') {
      const introParts = [appendix.intro].filter(Boolean);
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(resolveCap6AppendixTitle(appendix.title))}, ${sqlLiteral(resolveCap6AppendixDescription(t.slug, appendix.anchorId, introParts.join('\n\n')))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
      for (const group of appendix.groups ?? []) {
        const groupIntro = [group.intro].filter(Boolean).join('\n\n');
        if (groupIntro) {
          benefitLines.push(
            `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(resolveCap6AppendixTitle(group.title))}, ${sqlLiteral(resolveCap6AppendixDescription(t.slug, group.anchorId, groupIntro))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
          );
          sort += 1;
        }
        for (const entry of group.entries ?? []) {
          benefitLines.push(
            `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(resolveCap6BenefitName(t.slug, entry.anchorId, entry.name))}, ${sqlLiteral(resolveCap6AppendixDescription(t.slug, entry.anchorId, entry.description))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
          );
          sort += 1;
        }
      }
      continue;
    }

    const appendixName = `Apêndice: ${resolveCap6AppendixTitle(appendix.title)}`;
    benefitLines.push(
      `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(t.slug)}), ${sort}, ${sqlLiteral(appendixName)}, ${sqlLiteral(resolveCap6AppendixDescription(t.slug, appendix.anchorId, appendix.description ?? ''))}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
    );
    sort += 1;
  }

  return benefitLines;
}

/** @param {import('../docs/source/extracts/grim-hollow/cap6-transformations.json')['transformations'][0]} t @param {{ seedId: string; slug: string }} meta */
function buildTransformationBenefitsSql(t, meta) {
  const lines = buildTransformationBenefitLines(t);
  return `-- ${meta.seedId} — ${t.namePt} (${t.slug})
-- Benefícios da transformação; requer J019 (shell phb_feat).

${lines.join('\n\n')}
`;
}

const cap6 = JSON.parse(fs.readFileSync(cap6Path, 'utf8'));
fs.mkdirSync(outDir, { recursive: true });

fs.writeFileSync(
  path.join(outDir, 'J019_phb_feat_ghpg_transformations.sql'),
  buildFeatShellSql(cap6),
  'utf8',
);

const bySlug = new Map(cap6.transformations.map((t) => [t.slug, t]));

for (const meta of CAP6_BENEFIT_SEEDS) {
  const t = bySlug.get(meta.slug);
  if (!t) {
    console.warn(`Transformação ausente no extract: ${meta.slug}`);
    continue;
  }
  fs.writeFileSync(
    path.join(outDir, meta.file),
    buildTransformationBenefitsSql(t, meta),
    'utf8',
  );
}

console.log(`J019 shell — ${cap6.transformationCount} transformações`);
console.log(`J048–J059 — ${CAP6_BENEFIT_SEEDS.length} arquivos de benefícios`);
