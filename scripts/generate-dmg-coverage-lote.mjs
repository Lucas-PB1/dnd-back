/**
 * Gera D013 (kind: coverage + appliesTo/appliesFilter).
 * Uso: node scripts/generate-dmg-coverage-lote.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sourceDir = path.join(__dirname, '../docs/source');
const { items } = JSON.parse(
  fs.readFileSync(path.join(sourceDir, 'dmg-2024-itens-magicos-az.json'), 'utf8'),
);
const bySlug = new Map(items.map((i) => [i.slug, i]));

/** @type {{ slug: string, appliesTo: string, appliesFilter: string, requiresTierBonus?: boolean, note?: string }[]} */
const COVERAGES = [
  { slug: 'arma-1-2-ou-3', appliesTo: 'weapon', appliesFilter: 'qualquer simples ou marcial', requiresTierBonus: true },
  { slug: 'armadura-1-2-ou-3', appliesTo: 'armor', appliesFilter: 'qualquer leve media ou pesada', requiresTierBonus: true },
  { slug: 'escudo-1-2-ou-3', appliesTo: 'shield', appliesFilter: 'escudo', requiresTierBonus: true },
  { slug: 'municao-1-2-ou-3', appliesTo: 'ammunition', appliesFilter: 'qualquer municao', requiresTierBonus: true },
  {
    slug: 'varinha-do-mago-de-guerra-1-2-ou-3',
    appliesTo: 'wand',
    appliesFilter: 'varinha',
    requiresTierBonus: true,
  },
  {
    slug: 'ataduras-do-poder-desarmado',
    appliesTo: 'unarmed',
    appliesFilter: 'ataque-desarmado',
  },
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

const sqlParts = [
  '-- DMG §3.1: marca coberturas (kind + appliesTo + appliesFilter)',
  '-- Gerado por scripts/generate-dmg-coverage-lote.mjs',
  '',
];

for (const r of resolved) {
  const patch = {
    kind: 'coverage',
    appliesTo: r.appliesTo,
    appliesFilter: r.appliesFilter,
  };
  if (r.requiresTierBonus) {
    patch.requiresTierBonus = true;
  }
  const patchJson = JSON.stringify(patch);
  sqlParts.push(`UPDATE rpg.phb_item`);
  sqlParts.push(
    `SET properties = COALESCE(properties, '{}'::jsonb) || '${sqlEscape(patchJson)}'::jsonb`,
  );
  sqlParts.push(`WHERE slug = '${sqlEscape(r.slug)}';`);
  sqlParts.push('');
}

const sqlPath = path.join(
  __dirname,
  '../database/seeds/dmg/D013_phb_item_coverage_flag.sql',
);

fs.writeFileSync(sqlPath, sqlParts.join('\n'), 'utf8');

console.log('wrote', sqlPath);
console.log('count', resolved.length);
if (missing.length) console.log('missing in JSON (ok if seed-only):', missing);
