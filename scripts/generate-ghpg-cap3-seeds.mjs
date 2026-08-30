/**
 * Gera seeds J014–J018 + atualização de citações (Grim Hollow Cap. 3 backgrounds + Cap. 4 feats).
 * Uso: node scripts/generate-ghpg-cap3-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap3Path = path.join(apiRoot, 'docs/source/ghpg-cap3-backgrounds-extract.json');
const cap4Path = path.join(apiRoot, 'docs/source/ghpg-cap4-feats-extract.json');
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');

const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION_CAP3 = `${EDITION}:chapter-3-backgrounds`;
const CITATION_CAP4 = `${EDITION}:chapter-4-character-feats`;
const CITATION_CAP6 = `${EDITION}:chapter-6-transformations`;

const OLD_WRONG_SLUGS = [
  'gh-academic',
  'gh-aristocrat',
  'gh-clan-member',
  'gh-clergy',
  'gh-common-folk',
  'gh-criminal',
  'gh-militarist',
  'gh-outlander',
  'gh-pauper',
  'gh-seafarer',
];

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

function buildCitationsSql() {
  return `-- Grim Hollow — citações Cap. 3, 4 e 6 (backgrounds + feats + transformations)

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES
  (
    ${sqlLiteral(CITATION_CAP3)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    3,
    'Grim Hollow — Capítulo 3: Antecedentes',
    NOW()
  ),
  (
    ${sqlLiteral(CITATION_CAP4)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    4,
    'Grim Hollow — Capítulo 4: Talentos de Personagem',
    NOW()
  ),
  (
    ${sqlLiteral(CITATION_CAP6)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    6,
    'Grim Hollow — Capítulo 6: Transformações',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, antecedentes PHB 2024, talentos, equipamento avançado e transformações; textos em PT-BR onde disponível'
WHERE slug = ${sqlLiteral(EDITION)};
`;
}

/** @param {import('../docs/source/ghpg-cap4-feats-extract.json')} cap4 */
function buildFeatsSql(cap4) {
  const ghFeats = cap4.feats.filter((f) => f.slug !== 'advanced-weapon-proficiency');
  const featRows = ghFeats.map(
    (f) => `(
  ${sqlLiteral(f.slug)},
  ${sqlLiteral(f.nameEn)},
  ${sqlLiteral(f.category)},
  ${f.repeatable ? 'TRUE' : 'FALSE'},
  ${f.prerequisite ? sqlLiteral(f.prerequisite) : 'NULL'},
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlLiteral(CITATION_CAP4)})
)`,
  );

  const benefitLines = [];
  for (const f of ghFeats) {
    let sort = 1;
    if (f.intro) {
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(f.slug)}), ${sort}, 'Visão geral', ${sqlLiteral(f.intro)}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
    }
    for (const b of f.benefits) {
      benefitLines.push(
        `INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(f.slug)}), ${sort}, ${sqlLiteral(b.name)}, ${sqlLiteral(b.description)}) ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
      );
      sort += 1;
    }
  }

  return `-- Grim Hollow Cap. 4 — talentos referenciados por antecedentes e catálogo GH

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
${featRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  repeatable = EXCLUDED.repeatable,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

${benefitLines.join('\n\n')}
`;
}

function toolProficiencySql(bg) {
  const tp = bg.toolProficiency;
  if (!tp) return { desc: 'NULL', kind: 'NULL', itemId: 'NULL', categoryId: 'NULL' };

  if (tp.kind === 'fixed' && tp.itemSlug) {
    return {
      desc: sqlLiteral(tp.description),
      kind: sqlLiteral('fixed'),
      itemId: `(SELECT id FROM rpg.phb_item WHERE slug = ${sqlLiteral(tp.itemSlug)})`,
      categoryId: 'NULL',
    };
  }
  if (tp.choiceItemSlugs?.length) {
    return {
      desc: sqlLiteral(tp.description),
      kind: sqlLiteral('choice'),
      itemId: 'NULL',
      categoryId: 'NULL',
    };
  }
  if (tp.toolCategorySlug === 'instrument') {
    return {
      desc: sqlLiteral(tp.description),
      kind: sqlLiteral('choice'),
      itemId: 'NULL',
      categoryId: `(SELECT id FROM rpg.phb_tool_category WHERE slug = 'instrument')`,
    };
  }
  if (tp.toolCategorySlug === 'artisan') {
    return {
      desc: sqlLiteral(tp.description),
      kind: sqlLiteral('choice'),
      itemId: 'NULL',
      categoryId: `(SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan')`,
    };
  }
  if (tp.choiceOptions?.includes('instrument') && tp.choiceOptions?.includes('artisan')) {
    return {
      desc: sqlLiteral(tp.description),
      kind: sqlLiteral('choice'),
      itemId: 'NULL',
      categoryId: `(SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan')`,
    };
  }
  return {
    desc: sqlLiteral(tp.description),
    kind: 'NULL',
    itemId: 'NULL',
    categoryId: 'NULL',
  };
}

/** @param {import('../docs/source/ghpg-cap3-backgrounds-extract.json')} cap3 */
function buildBackgroundsSql(cap3) {
  const optionalNote = cap3.optionalRule?.heritageAbilityScoresUnlimited
    ? '\n\nRegra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.'
    : '';

  const rows = cap3.backgrounds.map((bg) => {
    const tp = toolProficiencySql(bg);
    const featSlug = bg.feat?.slug ?? null;
    const variantNote = bg.feat?.variant ? ` (${bg.feat.variant})` : '';
    const summary = `Antecedente Grim Hollow (PHB 2024). Talento de origem: ${featSlug ?? '—'}${variantNote}.${optionalNote}`;

    return `(
  ${sqlLiteral(bg.slug)},
  ${sqlLiteral(bg.namePt)},
  ${sqlLiteral(bg.description)},
  ${sqlLiteral('Antecedente Grim Hollow')},
  ${sqlLiteral(summary)},
  ${featSlug ? `(SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(featSlug)})` : 'NULL'},
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlLiteral(CITATION_CAP3)}),
  ${bg.equipment?.goldOptionB ?? 50},
  ${tp.desc},
  ${tp.kind},
  ${tp.itemId},
  ${tp.categoryId},
  0
)`;
  });

  return `-- Grim Hollow Cap. 3 — antecedentes jogáveis (PHB 2024 style)

INSERT INTO rpg.phb_background (
  slug, name, description, tagline, summary,
  feat_id, source_citation_id, equipment_gold_option,
  tool_proficiency_description, tool_proficiency_kind, tool_item_id, tool_category_id,
  language_choice_count
)
VALUES
${rows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  feat_id = EXCLUDED.feat_id,
  source_citation_id = EXCLUDED.source_citation_id,
  equipment_gold_option = EXCLUDED.equipment_gold_option,
  tool_proficiency_description = EXCLUDED.tool_proficiency_description,
  tool_proficiency_kind = EXCLUDED.tool_proficiency_kind,
  tool_item_id = EXCLUDED.tool_item_id,
  tool_category_id = EXCLUDED.tool_category_id;
`;
}

/** @param {import('../docs/source/ghpg-cap3-backgrounds-extract.json')} cap3 */
function buildAbilitySkillSql(cap3) {
  const abilityLines = [];
  const skillLines = [];

  for (const bg of cap3.backgrounds) {
    bg.abilitySlugs.forEach((ability, idx) => {
      abilityLines.push(
        `((SELECT id FROM rpg.phb_background WHERE slug = ${sqlLiteral(bg.slug)}), (SELECT id FROM rpg.phb_ability WHERE slug = ${sqlLiteral(ability)}), ${idx + 1})`,
      );
    });
    for (const skill of bg.skillSlugs) {
      skillLines.push(
        `((SELECT id FROM rpg.phb_background WHERE slug = ${sqlLiteral(bg.slug)}), (SELECT id FROM rpg.phb_skill WHERE slug = ${sqlLiteral(skill)}))`,
      );
    }
  }

  return `-- Grim Hollow Cap. 3 — atributos e perícias dos antecedentes

INSERT INTO rpg.phb_background_ability_option (background_id, ability_id, sort_order)
VALUES
${abilityLines.join(',\n')}
ON CONFLICT (background_id, ability_id) DO UPDATE SET sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_background_skill (background_id, skill_id)
VALUES
${skillLines.join(',\n')}
ON CONFLICT (background_id, skill_id) DO NOTHING;
`;
}

/** @param {import('../docs/source/ghpg-cap3-backgrounds-extract.json')} cap3 */
function buildEquipmentSql(cap3) {
  const packageLines = [];
  const itemLines = [];

  for (const bg of cap3.backgrounds) {
    const eq = bg.equipment?.optionA;
    if (!eq) continue;

    packageLines.push(
      `('background', (SELECT id FROM rpg.phb_background WHERE slug = ${sqlLiteral(bg.slug)}), 'a', 'A', ${eq.gold ?? 0}, 1)`,
    );

    eq.items.forEach((item, idx) => {
      const itemId = item.itemSlug
        ? `(SELECT id FROM rpg.phb_item WHERE slug = ${sqlLiteral(item.itemSlug)})`
        : 'NULL';
      const choiceText =
        item.choiceText != null
          ? sqlLiteral(item.choiceText)
          : item.itemSlug
            ? 'NULL'
            : sqlLiteral(item.name);
      itemLines.push(
        `((SELECT p.id FROM rpg.phb_starting_package p JOIN rpg.phb_background b ON b.id = p.owner_id WHERE p.source = 'background' AND b.slug = ${sqlLiteral(bg.slug)} AND p.slug = 'a'), ${itemId}, ${choiceText}, NULL, ${item.quantity ?? 1}, ${idx + 1})`,
      );
    });
  }

  return `-- Grim Hollow Cap. 3 — pacotes de equipamento inicial (opção A)

INSERT INTO rpg.phb_starting_package (source, owner_id, slug, label, gold, sort_order)
VALUES
${packageLines.join(',\n')}
ON CONFLICT (source, owner_id, slug) DO UPDATE SET gold = EXCLUDED.gold, label = EXCLUDED.label;

INSERT INTO rpg.phb_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
VALUES
${itemLines.join(',\n')}
ON CONFLICT DO NOTHING;
`;
}

function buildCleanupSql() {
  const slugList = OLD_WRONG_SLUGS.map((s) => sqlLiteral(s)).join(', ');
  return `-- Remove antecedentes avançados incorretos (wiki Advanced Backgrounds)

DELETE FROM rpg.phb_background
WHERE slug IN (${slugList});
`;
}

const ARTISAN_TOOL_SLUGS = [
  'ferramentas-de-carpinteiro',
  'ferramentas-de-cartografo',
  'ferramentas-de-coureiro',
  'ferramentas-de-entalhador',
  'ferramentas-de-ferreiro',
  'ferramentas-de-funileiro',
  'ferramentas-de-joalheiro',
  'ferramentas-de-oleiro',
  'ferramentas-de-pedreiro',
  'ferramentas-de-sapateiro',
  'ferramentas-de-tecelao',
  'ferramentas-de-vidreiro',
];

const INSTRUMENT_SLUGS = [
  'gaita-de-foles',
  'tambor',
  'salterio',
  'flauta',
  'trompa',
  'alaude',
  'lira',
  'flauta-de-pan',
  'charamela',
  'viola',
];

/** @param {import('../docs/source/ghpg-cap3-backgrounds-extract.json').backgrounds[0]['toolProficiency']} tp */
function resolveToolOptionSlugs(tp) {
  if (!tp || tp.kind !== 'choice') return [];
  if (tp.choiceItemSlugs?.length) return tp.choiceItemSlugs;
  if (tp.toolCategorySlug === 'instrument') return INSTRUMENT_SLUGS;
  if (tp.toolCategorySlug === 'artisan') return ARTISAN_TOOL_SLUGS;
  if (tp.choiceOptions?.includes('instrument') && tp.choiceOptions?.includes('artisan')) {
    return [...INSTRUMENT_SLUGS, ...ARTISAN_TOOL_SLUGS];
  }
  return [];
}

/** @param {import('../docs/source/ghpg-cap3-backgrounds-extract.json')} cap3 */
function buildToolOptionsSql(cap3) {
  const lines = [];
  for (const bg of cap3.backgrounds) {
    for (const itemSlug of resolveToolOptionSlugs(bg.toolProficiency)) {
      lines.push(
        `((SELECT id FROM rpg.phb_background WHERE slug = ${sqlLiteral(bg.slug)}), (SELECT id FROM rpg.phb_item WHERE slug = ${sqlLiteral(itemSlug)}))`,
      );
    }
  }
  if (!lines.length) return null;

  return `-- Grim Hollow Cap. 3 — opções de ferramenta (whitelist por antecedente)

INSERT INTO rpg.phb_background_tool_option (background_id, item_id)
VALUES
${lines.join(',\n')}
ON CONFLICT DO NOTHING;
`;
}

const cap3 = JSON.parse(fs.readFileSync(cap3Path, 'utf8'));
const cap4 = JSON.parse(fs.readFileSync(cap4Path, 'utf8'));

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'J009_phb_edition_citation_cap1_cap3.sql'), buildCitationsSql(), 'utf8');
fs.writeFileSync(path.join(outDir, 'J014_phb_feat_ghpg_cap4.sql'), buildFeatsSql(cap4), 'utf8');
fs.writeFileSync(path.join(outDir, 'J015_phb_background_ghpg.sql'), buildBackgroundsSql(cap3), 'utf8');
fs.writeFileSync(path.join(outDir, 'J016_phb_background_ability_skill_ghpg.sql'), buildAbilitySkillSql(cap3), 'utf8');
fs.writeFileSync(path.join(outDir, 'J017_phb_background_equipment_ghpg.sql'), buildEquipmentSql(cap3), 'utf8');
fs.writeFileSync(path.join(outDir, 'J018_cleanup_wrong_gh_backgrounds.sql'), buildCleanupSql(), 'utf8');
const toolOptionsSql = buildToolOptionsSql(cap3);
if (toolOptionsSql) {
  fs.writeFileSync(path.join(outDir, 'J020_phb_background_tool_option_ghpg.sql'), toolOptionsSql, 'utf8');
}

console.log('Seeds J009 (atualizado), J014–J018, J020 gerados em database/seeds/grim-hollow/');
console.log(`  backgrounds: ${cap3.backgroundCount}`);
console.log(`  gh feats: ${cap4.featCount}`);
