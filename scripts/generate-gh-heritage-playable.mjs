/**
 * Gera J021 (pool de traços + slots jogáveis) e V070 (view trait choices).
 * Uso: node scripts/generate-gh-heritage-playable.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap1Path = extracts.grimHollow.cap1Heritages;
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');
const viewsDir = path.join(apiRoot, 'database/migrations/060_views');
const v065Path = path.join(viewsDir, 'V065_v_phb_species_trait_choices_feathren.sql');

const EDITION = 'grim-hollow-players-guide-2024-en';
const HERITAGE_TRAIT_INDEX = 'gh-heritage-traits';
const TRAIT_SLOTS = Array.from({ length: 8 }, (_, i) => `gh_heritage_trait_${i + 1}`);

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

function categoryLabelPt(category) {
  if (category === 'combat') return 'Combate';
  if (category === 'exploration') return 'Exploração';
  return 'Interpretação';
}

function firstParagraph(text) {
  return String(text ?? '').split('\n\n')[0]?.trim() ?? '';
}

function heritageAllowsSpeedTrade(heritage) {
  const blob = `${heritage.speed ?? ''} ${heritage.description ?? ''}`;
  return /extra traditional trait|gain an extra|deslocamento por 1[,.]5\s*m/i.test(blob);
}

function heritageAllowsSizeChoice(heritage) {
  const blob = `${heritage.size ?? ''} ${heritage.description ?? ''}`;
  return /Pequeno ou Médio|Small or Medium/i.test(blob);
}

/** @param {import('../docs/source/extracts/grim-hollow/cap1-heritages.json')} cap1 */
function buildJ021(cap1) {
  const lines = [
    '-- Grim Hollow Cap. 1 — heranças jogáveis: pool de traços + 8 slots por herança',
    '',
    `INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(HERITAGE_TRAIT_INDEX)}), 'ghHeritageTraitId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;`,
    '',
  ];

  const optionRows = cap1.traits.map((t, idx) => {
    const label = `[${categoryLabelPt(t.category)}] ${t.name.replace(/\.$/, '')}`;
    const benefit = firstParagraph(t.description);
    return `(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(HERITAGE_TRAIT_INDEX)}),
  'ghHeritageTraitId',
  ${sqlLiteral(t.slug)},
  ${sqlLiteral(label)},
  ${idx + 1},
  ${sqlLiteral(benefit)},
  ${sqlLiteral(benefit)},
  ${sqlLiteral(EDITION)}
)`;
  });

  lines.push(
    `INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit, edition_slug)
VALUES
${optionRows.join(',\n')}
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit,
  edition_slug = EXCLUDED.edition_slug;`,
    '',
  );

  for (const heritage of cap1.heritages) {
    for (let i = 0; i < TRAIT_SLOTS.length; i += 1) {
      const kind = TRAIT_SLOTS[i];
      lines.push(
        `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(heritage.slug)}),
  ${sqlLiteral(`Traço modular ${i + 1}`)},
  ${sqlLiteral('Escolha um traço tradicional do pool de herança Grim Hollow.')},
  ${sqlLiteral(kind)}::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;`,
      );
    }

    if (heritageAllowsSpeedTrade(heritage)) {
      lines.push(
        `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(heritage.slug)}),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(heritage.slug)}),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;`,
      );
    }

    if (heritageAllowsSizeChoice(heritage)) {
      lines.push(
        `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(heritage.slug)}),
  'Tamanho',
  'Pequeno ou Médio, conforme você determinar.',
  'gh_heritage_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;`,
      );
    }

    lines.push('');
  }

  return lines.join('\n');
}

function buildGhViewUnions() {
  const unions = [];

  for (const kind of [...TRAIT_SLOTS, 'gh_heritage_trait_9']) {
    unions.push(`UNION ALL
-- GH heritage modular traits (${kind})
SELECT
  sp.slug AS species_slug,
  t.name AS trait_name,
  t.choice_kind,
  ov.value_id AS choice_slug,
  ov.label AS choice_name,
  ov.level1_benefit,
  NULL::text AS spell_level3_slug,
  NULL::text AS spell_level5_slug,
  NULL::text AS damage_type,
  ov.edition_slug AS edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_species pool ON pool.slug = ${sqlLiteral(HERITAGE_TRAIT_INDEX)}
JOIN rpg.phb_option_value ov
  ON ov.scope = 'species'::rpg.option_scope
 AND ov.owner_id = pool.id
 AND ov.option_key = 'ghHeritageTraitId'
WHERE sp.slug LIKE 'gh-%'
  AND sp.slug <> ${sqlLiteral(HERITAGE_TRAIT_INDEX)}
  AND t.choice_kind = ${sqlLiteral(kind)}::rpg.species_choice_kind`);
  }

  unions.push(`UNION ALL
-- GH heritage speed trade
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  v.choice_slug,
  v.choice_name,
  v.level1_benefit,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN (VALUES
  ('no', 'Não', 'Mantém o deslocamento base da herança.'),
  ('yes', 'Sim', 'Reduz 1,5 m de deslocamento; escolha o 9º traço modular.')
) AS v(choice_slug, choice_name, level1_benefit) ON TRUE
WHERE sp.slug LIKE 'gh-%'
  AND sp.slug <> ${sqlLiteral(HERITAGE_TRAIT_INDEX)}
  AND t.choice_kind = 'gh_heritage_speed_trade'::rpg.species_choice_kind`);

  unions.push(`UNION ALL
-- GH heritage size
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  v.choice_slug,
  v.choice_name,
  v.level1_benefit,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN (VALUES
  ('small', 'Pequeno', 'Tamanho Pequeno.'),
  ('medium', 'Médio', 'Tamanho Médio.')
) AS v(choice_slug, choice_name, level1_benefit) ON TRUE
WHERE sp.slug LIKE 'gh-%'
  AND sp.slug <> ${sqlLiteral(HERITAGE_TRAIT_INDEX)}
  AND t.choice_kind = 'gh_heritage_size'::rpg.species_choice_kind`);

  return unions.join('\n');
}

function buildV070() {
  const base = fs.readFileSync(v065Path, 'utf8');
  const marker = 'CREATE VIEW rpg.v_phb_species_trait_choices AS';
  const start = base.indexOf(marker);
  if (start < 0) throw new Error('V065 view header not found');

  const ghUnions = buildGhViewUnions();
  const body = base
    .slice(start)
    .replace(/DROP VIEW IF EXISTS rpg\.v_phb_species_trait_choices;\s*/i, '')
    .trimEnd()
    .replace(/;\s*$/, '');

  return `-- Inclui heranças Grim Hollow (8 traços modulares + opcionais) em v_phb_species_trait_choices

DROP VIEW IF EXISTS rpg.v_phb_species_trait_choices;

${body}
${ghUnions};
`;
}

const cap1 = JSON.parse(fs.readFileSync(cap1Path, 'utf8'));

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'J021_phb_species_heritage_playable.sql'), `${buildJ021(cap1)}\n`, 'utf8');
fs.writeFileSync(
  path.join(viewsDir, 'V070_v_phb_species_trait_choices_gh_heritage.sql'),
  buildV070(),
  'utf8',
);

console.log('Gerado J021_phb_species_heritage_playable.sql');
console.log('Gerado V070_v_phb_species_trait_choices_gh_heritage.sql');
console.log(`  heranças: ${cap1.heritageCount}, traços no pool: ${cap1.traitCount}`);
