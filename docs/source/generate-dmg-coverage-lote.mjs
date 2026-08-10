/**
 * Gera taxonomia + D013 (kind: coverage + appliesTo/appliesFilter).
 * node docs/source/generate-dmg-coverage-lote.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '../..');
const { items } = JSON.parse(
  fs.readFileSync(path.join(__dirname, 'dmg-2024-itens-magicos-az.json'), 'utf8'),
);
const bySlug = new Map(items.map((i) => [i.slug, i]));

/** @type {{ slug: string, appliesTo: string, appliesFilter: string, note?: string }[]} */
const COVERAGES = [
  // +1/+2/+3
  { slug: 'arma-1-2-ou-3', appliesTo: 'weapon', appliesFilter: 'qualquer simples ou marcial' },
  { slug: 'armadura-1-2-ou-3', appliesTo: 'armor', appliesFilter: 'qualquer leve media ou pesada' },
  { slug: 'escudo-1-2-ou-3', appliesTo: 'shield', appliesFilter: 'escudo' },
  { slug: 'municao-1-2-ou-3', appliesTo: 'ammunition', appliesFilter: 'qualquer municao' },
  {
    slug: 'varinha-do-mago-de-guerra-1-2-ou-3',
    appliesTo: 'wand',
    appliesFilter: 'varinha',
  },
  {
    slug: 'ataduras-do-poder-desarmado',
    appliesTo: 'unarmed',
    appliesFilter: 'ataque-desarmado',
  },
  // material / qualidade
  {
    slug: 'arma-de-adamantina',
    appliesTo: 'weapon',
    appliesFilter: 'qualquer municao ou arma corpo a corpo',
  },
  { slug: 'arma-de-prata', appliesTo: 'weapon', appliesFilter: 'qualquer simples ou marcial' },
  {
    slug: 'armadura-adamantina',
    appliesTo: 'armor',
    appliesFilter: 'qualquer media ou pesada exceto peles',
  },
  {
    slug: 'armadura-de-mitral',
    appliesTo: 'armor',
    appliesFilter: 'qualquer media ou pesada',
  },
  {
    slug: 'armadura-facil-de-tirar',
    appliesTo: 'armor',
    appliesFilter: 'qualquer media ou pesada',
  },
  { slug: 'armadura-fumegante', appliesTo: 'armor', appliesFilter: 'qualquer leve' },
  { slug: 'armadura-reluzente', appliesTo: 'armor', appliesFilter: 'qualquer' },
  {
    slug: 'armadura-do-marinheiro',
    appliesTo: 'armor',
    appliesFilter: 'qualquer',
  },
  // qualquer / poder genérico
  { slug: 'arma-implacavel', appliesTo: 'weapon', appliesFilter: 'qualquer' },
  {
    slug: 'arma-magificada',
    appliesTo: 'weapon',
    appliesFilter: 'qualquer',
    note: 'params: spellSlug + escola (Enspelled)',
  },
  { slug: 'arma-sempre-alerta', appliesTo: 'weapon', appliesFilter: 'qualquer' },
  {
    slug: 'armadura-de-resistencia',
    appliesTo: 'armor',
    appliesFilter: 'qualquer leve media ou pesada',
  },
  {
    slug: 'armadura-de-vulnerabilidade',
    appliesTo: 'armor',
    appliesFilter: 'qualquer',
  },
  { slug: 'armadura-demoniaca', appliesTo: 'armor', appliesFilter: 'qualquer' },
  { slug: 'municao-exterminadora', appliesTo: 'ammunition', appliesFilter: 'qualquer' },
  { slug: 'municao-impactante', appliesTo: 'ammunition', appliesFilter: 'qualquer' },
  {
    slug: 'sorvedora-das-nove-almas',
    appliesTo: 'weapon',
    appliesFilter: 'qualquer arma corpo a corpo',
  },
  { slug: 'defensora', appliesTo: 'weapon', appliesFilter: 'qualquer' },
  { slug: 'matadora-de-dragoes', appliesTo: 'weapon', appliesFilter: 'qualquer' },
  { slug: 'matadora-de-gigantes', appliesTo: 'weapon', appliesFilter: 'qualquer' },
  { slug: 'sacro-vingadora', appliesTo: 'weapon', appliesFilter: 'qualquer' },
  // lista arma / armadura — filter do header quando existir
  { slug: 'escara-gelida', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-da-precisao', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-da-vinganca', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-dancarina', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-laceradora', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-lunar', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-usurpadora-de-vida', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'espada-vorpal', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'garra-silvestre', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'lamina-da-sorte', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'machado-do-carrasco', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'machado-berserker', appliesTo: 'weapon', appliesFilter: null },
  {
    slug: 'lingua-flamejante',
    appliesTo: 'weapon',
    appliesFilter: 'qualquer arma corpo a corpo',
  },
  { slug: 'arco-de-energia', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'arco-do-juramento', appliesTo: 'weapon', appliesFilter: null },
  { slug: 'martelo-do-trovao', appliesTo: 'weapon', appliesFilter: null },
  {
    slug: 'armadura-de-placas-das-formas-etereas',
    appliesTo: 'armor',
    appliesFilter: null,
  },
  {
    slug: 'armadura-de-placas-do-povo-anao',
    appliesTo: 'armor',
    appliesFilter: null,
  },
  { slug: 'cota-de-malha-elfica', appliesTo: 'armor', appliesFilter: null },
  { slug: 'cota-de-malha-ifriti', appliesTo: 'armor', appliesFilter: null },
];

function filterFromHeader(header) {
  if (!header) return null;
  const m = header.match(
    /(?:Arma|Armadura|Muni[cç][aã]o|Escudo|Varinha)\s*\(([^)]+)\)/i,
  );
  if (!m) return null;
  return m[1].replace(/\s+/g, ' ').trim();
}

function sqlEscape(s) {
  return String(s).replace(/'/g, "''");
}

const resolved = [];
const missing = [];

for (const row of COVERAGES) {
  const it = bySlug.get(row.slug);
  if (!it) missing.push(row.slug);
  const fromHeader = it ? filterFromHeader(it.header) : null;
  const appliesFilter =
    fromHeader || row.appliesFilter || 'ver-header-manual';
  resolved.push({
    ...row,
    name: it?.name ?? row.slug,
    header: it?.header ?? '',
    appliesFilter,
  });
}

const taxLines = [
  '# Taxonomia — coberturas confirmadas (§3.1)',
  `# Gerado por generate-dmg-coverage-lote.mjs`,
  `# Total: ${resolved.length}`,
  '',
  'meta:',
  '  fase: 2-taxonomy',
  '  padrao: coverage',
  '  nota: |',
  '    properties.kind=coverage + appliesTo + appliesFilter.',
  '    Overlay inventário (fase 2b): attach/detach na peça base (`P021`).',
  '    Busca/compêndio pode usar esses campos.',
  '',
  'items:',
];

for (const r of resolved) {
  taxLines.push(`  - slug: ${r.slug}`);
  taxLines.push(`    name: ${JSON.stringify(r.name)}`);
  taxLines.push(`    kind: coverage`);
  taxLines.push(`    appliesTo: ${r.appliesTo}`);
  taxLines.push(`    appliesFilter: ${JSON.stringify(r.appliesFilter)}`);
  if (r.note) taxLines.push(`    note: ${JSON.stringify(r.note)}`);
  taxLines.push(`    status: tagged`);
  taxLines.push('');
}

const sqlParts = [
  '-- DMG §3.1: marca coberturas (kind + appliesTo + appliesFilter)',
  '-- Gerado por docs/source/generate-dmg-coverage-lote.mjs',
  '',
];

for (const r of resolved) {
  const patch = JSON.stringify({
    kind: 'coverage',
    appliesTo: r.appliesTo,
    appliesFilter: r.appliesFilter,
  });
  sqlParts.push(`UPDATE rpg.phb_item`);
  sqlParts.push(
    `SET properties = COALESCE(properties, '{}'::jsonb) || '${sqlEscape(patch)}'::jsonb`,
  );
  sqlParts.push(`WHERE slug = '${sqlEscape(r.slug)}';`);
  sqlParts.push('');
}

const taxPath = path.join(__dirname, 'dmg-item-mesa-taxonomy-coverages.yaml');
const sqlPath = path.join(
  root,
  'database/seeds/dmg/D013_phb_item_coverage_flag.sql',
);

fs.writeFileSync(taxPath, taxLines.join('\n'), 'utf8');
fs.writeFileSync(sqlPath, sqlParts.join('\n'), 'utf8');

console.log('wrote', taxPath);
console.log('wrote', sqlPath);
console.log('count', resolved.length);
if (missing.length) console.log('missing in JSON (ok if seed-only):', missing);
