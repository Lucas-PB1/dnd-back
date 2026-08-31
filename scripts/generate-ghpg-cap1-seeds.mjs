/**
 * Gera seeds J009–J011 (Grim Hollow — Cap. 1 Heritages).
 * Antecedentes: use scripts/generate-ghpg-cap3-seeds.mjs (J015+).
 * Uso: node scripts/generate-ghpg-cap1-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap1Path = extracts.grimHollow.cap1Heritages;
const ptOverlayPath = extracts.grimHollow.cap1HeritagesPt;
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

const CATEGORY_LABEL = {
  combat: 'Combate',
  exploration: 'Exploração',
  roleplaying: 'Interpretação',
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
        description: pt.description ?? h.description,
        size: pt.size ?? h.size,
        speed: pt.speed ?? h.speed,
        baseTraits: h.baseTraits.map((t, index) => ({
          name: pt.baseTraits?.[index]?.name ?? t.name,
          description: pt.baseTraits?.[index]?.description ?? t.description,
        })),
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
      };
    }),
  };
}

/** @param {ReturnType<typeof mergeCap1>} cap1 */
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

/** @param {ReturnType<typeof mergeCap1>} cap1 */
function buildHeritageTraitsSql(cap1) {
  const lines = [];

  for (const h of cap1.heritages) {
    for (const t of h.baseTraits) {
      if (
        t.name === 'Your draconic heritage marks you as a unique folk among the other heritages of Etharis' ||
        t.name.startsWith('Typically short and stout') ||
        t.name.startsWith('Though elves might pass')
      ) {
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
          `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = ${sqlLiteral(h.slug)}), ${sqlLiteral(`[Tradicional · ${label}] ${trait?.name ?? tr.name}`)}, ${sqlLiteral(body)}, NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;`,
        );
      }
    }
  }

  for (const t of cap1.traits) {
    const cat = CATEGORY_LABEL[t.category] ?? t.category;
    const improved = t.improvedName ? `\n\nTomar novamente: ${t.improvedName}.` : '';
    lines.push(
      `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), ${sqlLiteral(`[${cat}] ${t.name}`)}, ${sqlLiteral(`${t.description}${improved}`)}, NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;`,
    );
  }

  return `-- Grim Hollow Cap. 1 — traços de herança\n\n${lines.join('\n\n')}\n`;
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

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, subclasses, antecedentes, talentos, equipamento avançado e transformações; textos em PT-BR onde disponível'
WHERE slug = ${sqlLiteral(EDITION)};
`;

const cap1Raw = JSON.parse(fs.readFileSync(cap1Path, 'utf8'));
const ptOverlay = fs.existsSync(ptOverlayPath)
  ? JSON.parse(fs.readFileSync(ptOverlayPath, 'utf8'))
  : null;
const cap1 = mergeCap1(cap1Raw, ptOverlay);

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'J010_phb_species_heritage.sql'), buildHeritageSpeciesSql(cap1), 'utf8');
fs.writeFileSync(path.join(outDir, 'J011_phb_species_heritage_trait.sql'), buildHeritageTraitsSql(cap1), 'utf8');

console.log('Seeds J010–J011 gerados em database/seeds/grim-hollow/');
console.log(`  overlay PT: ${ptOverlay ? 'sim' : 'não'}`);
console.log('Antecedentes: node scripts/generate-ghpg-cap3-seeds.mjs');
