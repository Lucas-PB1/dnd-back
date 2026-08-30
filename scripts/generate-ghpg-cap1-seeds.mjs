/**
 * Gera seeds J009–J011 (Grim Hollow — Cap. 1 Heritages).
 * Antecedentes: use scripts/generate-ghpg-cap3-seeds.mjs (J015+).
 * Uso: node scripts/generate-ghpg-cap1-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap1Path = path.join(apiRoot, 'docs/source/ghpg-cap1-heritages-extract.json');
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');

const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION_CAP1 = `${EDITION}:chapter-1-heritages-traits`;
const CITATION_CAP3 = `${EDITION}:chapter-3-backgrounds`;
const SOURCE = 'grim-hollow';

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value).replace(/'/g, "''")}'`;
}

/** @param {unknown} value */
function sqlJson(value) {
  return `'${JSON.stringify(value).replace(/'/g, "''")}'::jsonb`;
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
    'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  rare: 'Herança rara — povo pouco comum em Etharis, com traços modulares.',
  eldritch:
    'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
};

/** @param {import('../docs/source/ghpg-cap1-heritages-extract.json')} cap1 */
function buildHeritageSpeciesSql(cap1) {
  const rows = cap1.heritages.map((h) => {
    const summary = CATEGORY_INTRO[h.category] ?? '';
    return `(
  ${sqlLiteral(h.slug)},
  ${sqlLiteral(h.namePt)},
  ${sqlLiteral('Humanoide')},
  ${sqlLiteral(h.size)},
  ${sqlLiteral(h.speed)},
  ${sqlLiteral(h.description)},
  ${sqlLiteral(summary)},
  ${sqlLiteral(h.categoryLabelPt)},
  ${sourceMeta({ kind: 'heritage', heritageCategory: h.category })}
)`;
  });

  rows.push(`(
  'gh-heritage-traits',
  'Traços de herança',
  'Referência',
  '—',
  '—',
  'Lista completa dos traços modulares de herança do Grim Hollow (combate, exploração e interpretação). Cada traço pode ser tomado mais de uma vez para benefícios aprimorados.',
  'Catálogo de traços modulares GH — escolha 8 ao criar um personagem com herança.',
  'Referência GH',
  ${sourceMeta({ kind: 'heritage-trait-index', catalogOnly: true })}
)`);

  return `-- Grim Hollow Cap. 1 — heritages jogáveis (wizard GH) + índice de traços

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, summary, tagline, source_meta
)
VALUES
${rows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  summary = EXCLUDED.summary,
  tagline = EXCLUDED.tagline,
  source_meta = EXCLUDED.source_meta;
`;
}

/** @param {import('../docs/source/ghpg-cap1-heritages-extract.json')} cap1 */
function buildHeritageTraitsSql(cap1) {
  const lines = [];

  for (const h of cap1.heritages) {
    for (const t of h.baseTraits) {
      if (t.name === 'Your draconic heritage marks you as a unique folk among the other heritages of Etharis') {
        continue;
      }
      lines.push(
        `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(h.slug)}), ${sqlLiteral(t.name)}, ${sqlLiteral(t.description)}, NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;`,
      );
    }

    const groups = [
      ['combat', 'Combate'],
      ['exploration', 'Exploração'],
      ['roleplaying', 'Interpretação'],
    ];
    for (const [key, label] of groups) {
      for (const tr of h.traditionalTraits[key] ?? []) {
        const trait = cap1.traits.find((x) => x.anchorId === tr.anchorId);
        const body = trait?.description
          ? `Traço tradicional sugerido (${label}).\n\n${trait.description}`
          : `Traço tradicional sugerido (${label}).`;
        lines.push(
          `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(h.slug)}), ${sqlLiteral(`[Tradicional · ${label}] ${tr.name}`)}, ${sqlLiteral(body)}, NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;`,
        );
      }
    }
  }

  for (const t of cap1.traits) {
    const cat =
      t.category === 'combat'
        ? 'Combate'
        : t.category === 'exploration'
          ? 'Exploração'
          : 'Interpretação';
    const improved = t.improvedName ? `\n\nTomar novamente: ${t.improvedName}.` : '';
    lines.push(
      `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), ${sqlLiteral(`[${cat}] ${t.name}`)}, ${sqlLiteral(`${t.description}${improved}`)}, NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;`,
    );
  }

  return `-- Grim Hollow Cap. 1 — traços de herança\n\n${lines.join('\n\n')}\n`;
}

/** @param {import('../docs/source/ghpg-cap3-backgrounds-structure.json')} cap3 */
function buildBackgroundsSql(cap3) {
  const rows = cap3.backgrounds.map((bg) => {
    const profList = bg.professions.map((p) => `• ${p}`).join('\n');
    const description = `Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).\n\nProfissões:\n${profList}\n\nRecomenda-se que todo o grupo use antecedentes avançados ou nenhum.`;
    return `(
  ${sqlLiteral(bg.slug)},
  ${sqlLiteral(bg.namePt)},
  ${sqlLiteral(description)},
  ${sqlLiteral('Antecedente avançado (GH)')},
  ${sqlLiteral('Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.')},
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlLiteral(CITATION_CAP3)}),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
)`;
  });

  return `-- Grim Hollow Cap. 3 — antecedentes avançados (catálogo)

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
  source_citation_id = EXCLUDED.source_citation_id;
`;
}

const citationsSql = `-- Grim Hollow — citações Cap. 1 e Cap. 3

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES
  (
    ${sqlLiteral(CITATION_CAP1)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    1,
    'Grim Hollow — Capítulo 1: Heranças e traços',
    NOW()
  ),
  (
    ${sqlLiteral(CITATION_CAP3)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    3,
    'Grim Hollow — Capítulo 3: Antecedentes',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, antecedentes avançados, armas e equipamento; textos em PT-BR onde disponível'
WHERE slug = ${sqlLiteral(EDITION)};
`;

const cap1 = JSON.parse(fs.readFileSync(cap1Path, 'utf8'));

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'J010_phb_species_heritage.sql'), buildHeritageSpeciesSql(cap1), 'utf8');
fs.writeFileSync(path.join(outDir, 'J011_phb_species_heritage_trait.sql'), buildHeritageTraitsSql(cap1), 'utf8');

console.log('Seeds J010–J011 gerados em database/seeds/grim-hollow/');
console.log('Antecedentes: node scripts/generate-ghpg-cap3-seeds.mjs');
