/**
 * Gera J037 (phb_heritage + phb_heritage_trait) e J038 (phb_heritage_traditional).
 * Uso: node scripts/generate-gh-heritage-catalog-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { HERITAGE_CATEGORY_LABEL_PT } from './lib/ghpg-cap1-heritage-pt.mjs';
import { extracts } from './lib/docs-source.mjs';
import { findTraitByAnchor } from './lib/ghpg-cap1-anchor.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap1Path = extracts.grimHollow.cap1Heritages;
const ptOverlayPath = extracts.grimHollow.cap1HeritagesPt;
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');

const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION_CAP1 = `${EDITION}:chapter-1-heritages-traits`;
const SOURCE = 'grim-hollow';

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

/** @param {unknown} value */
function sqlJson(value) {
  return `'${JSON.stringify(value).replace(/'/g, "''")}'::jsonb`;
}

/** @param {boolean} value */
function sqlBool(value) {
  return value ? 'TRUE' : 'FALSE';
}

/** @param {number | null | undefined} value */
function sqlIntOrNull(value) {
  if (value == null) return 'NULL';
  return String(value);
}

function sourceMeta(extra = {}) {
  return sqlJson({
    editionSlug: EDITION,
    book: 'Grim Hollow: Player\'s Guide',
    language: 'pt',
    citationSlug: CITATION_CAP1,
    source: SOURCE,
    ...extra,
  });
}

const CATEGORY_INTRO = {
  common:
    'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  rare: 'Variante rara — povo pouco comum em Etharis, com traços modulares.',
  eldritch:
    'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
};

/** @param {Record<string, unknown> | null} overlay */
function mergeCap1(cap1, overlay) {
  return {
    ...cap1,
    heritages: cap1.heritages.map((h) => {
      const pt = overlay?.heritages?.[h.slug];
      if (!pt) return h;
      return {
        ...h,
        namePt: pt.namePt ?? h.namePt,
        description: pt.description ?? h.description,
        size: pt.size ?? h.size,
        speed: pt.speed ?? h.speed,
      };
    }),
    traits: cap1.traits.map((t) => {
      const pt = overlay?.traits?.[t.slug];
      if (!pt) return t;
      return {
        ...t,
        name: pt.name ?? t.name,
        description: pt.description ?? t.description,
        improvedName: pt.improvedName ?? t.improvedName,
        benefitBase: pt.benefitBase ?? t.benefitBase,
        benefitImproved: pt.benefitImproved ?? t.benefitImproved,
      };
    }),
  };
}

function heritageAllowsSpeedTrade(heritage) {
  const blob = `${heritage.speed ?? ''} ${heritage.description ?? ''}`;
  return /extra traditional trait|gain an extra|deslocamento por 1[,.]5\s*m|reduce your Speed by 1\.5 m/i.test(
    blob,
  );
}

function heritageAllowsSizeChoice(heritage) {
  const blob = `${heritage.size ?? ''} ${heritage.description ?? ''}`;
  return /Pequeno ou Médio|Small or Medium/i.test(blob);
}

/** @param {ReturnType<typeof mergeCap1>} cap1 */
function buildJ037(cap1) {
  const heritageRows = cap1.heritages.map((h) => {
    const summary = CATEGORY_INTRO[h.category] ?? '';
    return `(
  ${sqlLiteral(h.slug)},
  ${sqlLiteral(h.namePt)},
  ${sqlLiteral(h.category)}::rpg.heritage_category,
  ${sqlLiteral('Humanoide')},
  ${sqlLiteral(h.size)},
  ${sqlLiteral(h.speed)},
  ${sqlBool(heritageAllowsSpeedTrade(h))},
  ${sqlBool(heritageAllowsSizeChoice(h))},
  ${sqlLiteral(h.description)},
  ${sqlLiteral(HERITAGE_CATEGORY_LABEL_PT[h.category] ?? h.categoryLabelPt)},
  ${sqlLiteral(summary)},
  NULL,
  ${sourceMeta({ kind: 'heritage', heritageCategory: h.category })}
)`;
  });

  const traitRows = cap1.traits.map((t) => {
    return `(
  ${sqlLiteral(t.slug)},
  ${sqlLiteral(t.anchorId)},
  ${sqlLiteral(t.category)}::rpg.heritage_trait_category,
  ${sqlLiteral(t.name.replace(/\.$/, ''))},
  ${sqlLiteral(t.description)},
  ${sqlLiteral(t.benefitBase ?? t.description)},
  ${t.benefitImproved ? sqlLiteral(t.benefitImproved) : 'NULL'},
  ${t.improvedName ? sqlLiteral(t.improvedName) : 'NULL'},
  ${sqlIntOrNull(t.maxTakes)},
  ${sqlLiteral(t.takeMode ?? 'stack')}::rpg.heritage_trait_take_mode
)`;
  });

  return `-- Grim Hollow Cap. 1 — catálogo de heranças e pool global de traços

INSERT INTO rpg.phb_heritage (
  slug, name, category, creature_type, size_rule, speed_rule,
  allows_speed_trade, allows_size_choice, description, tagline, summary, image_url, source_meta
)
VALUES
${heritageRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  creature_type = EXCLUDED.creature_type,
  size_rule = EXCLUDED.size_rule,
  speed_rule = EXCLUDED.speed_rule,
  allows_speed_trade = EXCLUDED.allows_speed_trade,
  allows_size_choice = EXCLUDED.allows_size_choice,
  description = EXCLUDED.description,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  source_meta = EXCLUDED.source_meta;

INSERT INTO rpg.phb_heritage_trait (
  slug, anchor_id, category, name, description,
  benefit_base, benefit_improved, improved_name, max_takes, take_mode
)
VALUES
${traitRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  anchor_id = EXCLUDED.anchor_id,
  category = EXCLUDED.category,
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  benefit_base = EXCLUDED.benefit_base,
  benefit_improved = EXCLUDED.benefit_improved,
  improved_name = EXCLUDED.improved_name,
  max_takes = EXCLUDED.max_takes,
  take_mode = EXCLUDED.take_mode;
`;
}

/** @param {ReturnType<typeof mergeCap1>} cap1 */
function buildJ038(cap1) {
  const lines = ['-- Grim Hollow Cap. 1 — builds tradicionais sugeridos por herança', ''];
  const groups = [
    ['combat', 'combat'],
    ['exploration', 'exploration'],
    ['roleplaying', 'roleplaying'],
  ];

  for (const heritage of cap1.heritages) {
    let sortOrder = 0;
    for (const [key, categoryHint] of groups) {
      for (const tr of heritage.traditionalTraits[key] ?? []) {
        const trait = findTraitByAnchor(cap1.traits, tr.anchorId);
        if (!trait) continue;
        sortOrder += 1;
        lines.push(
          `INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = ${sqlLiteral(heritage.slug)}),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = ${sqlLiteral(trait.slug)}),
  ${sortOrder},
  ${sqlLiteral(categoryHint)}::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;`,
        );
      }
    }
    lines.push('');
  }

  return `${lines.join('\n')}\n`;
}

const cap1Raw = JSON.parse(fs.readFileSync(cap1Path, 'utf8'));
const ptOverlay = fs.existsSync(ptOverlayPath)
  ? JSON.parse(fs.readFileSync(ptOverlayPath, 'utf8'))
  : null;
const cap1 = mergeCap1(cap1Raw, ptOverlay);

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'J037_phb_heritage_catalog.sql'), `${buildJ037(cap1)}\n`, 'utf8');
fs.writeFileSync(path.join(outDir, 'J038_phb_heritage_traditional.sql'), buildJ038(cap1), 'utf8');

console.log('Gerado J037_phb_heritage_catalog.sql');
console.log('Gerado J038_phb_heritage_traditional.sql');
console.log(`  heranças: ${cap1.heritageCount}, traços no pool: ${cap1.traitCount}`);
console.log(`  overlay PT: ${ptOverlay ? 'sim' : 'não'}`);
