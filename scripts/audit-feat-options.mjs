#!/usr/bin/env node
/**
 * Varre S022 (benefícios) vs defs em seeds S075+ e migrations 050_data (D002–D010).
 * Saída: docs/feat-options-audit.md
 *
 * Uso: node scripts/audit-feat-options.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

function read(rel) {
  return fs.readFileSync(path.join(root, rel), 'utf8');
}

function listFiles(dir, prefix) {
  const abs = path.join(root, dir);
  if (!fs.existsSync(abs)) return [];
  return fs
    .readdirSync(abs)
    .filter((name) => name.startsWith(prefix) && name.endsWith('.sql'))
    .sort()
    .map((name) => path.join(dir, name).replace(/\\/g, '/'));
}

const s022 = read('database/seeds/phb/S022_phb_feat_benefit.sql');

/** Benefícios com escolha na criação da ficha (não escolhas “no turno”). */
const COMBAT_TIME_SLUGS = new Set([
  'charger',
  'shield-master',
  'inspiring-leader',
]);

const benefitLineRe =
  /slug = '([^']+)'\), \d+, (?:'[^']*'|NULL), '([^']*(?:''[^']*)*)'/g;

/** @type {{ slug: string, excerpt: string, hasChoiceText: boolean }[]} */
const benefits = [];
let m;
while ((m = benefitLineRe.exec(s022)) !== null) {
  const slug = m[1];
  const text = m[2].replace(/''/g, "'");
  const hasChoiceText =
    /(^|[.!?\s])Escolha /i.test(text) ||
    /à sua escolha/i.test(text) ||
    /escolha um atributo/i.test(text) ||
    /escolha uma magia/i.test(text) ||
    /escolha um número de magias/i.test(text) ||
    /escolha uma perícia/i.test(text) ||
    /escolha um tipo de/i.test(text) ||
    /escolha um dos seguintes tipos/i.test(text) ||
    /escolha dois dos seguintes/i.test(text) ||
    /escolha três/i.test(text) ||
    /escolha dois truques/i.test(text);
  if (hasChoiceText) {
    benefits.push({ slug, excerpt: text.slice(0, 120), hasChoiceText: true });
  }
}

const optionSqlFiles = [
  ...listFiles('database/seeds/phb', 'S075'),
  ...listFiles('database/seeds/phb', 'S076'),
  ...listFiles('database/seeds/phb', 'S077'),
  ...listFiles('database/seeds/phb', 'S078'),
  ...listFiles('database/migrations/050_data', 'D00'),
].filter((f) => !f.includes('D001_') && !f.includes('D011_'));

let optionSql = '';
for (const file of optionSqlFiles) {
  optionSql += read(file) + '\n';
}
const optionSqlCompact = optionSql.replace(/\s+/g, ' ');

const defsBySlug = new Map();

const defOptionKeyRe =
  /\(\s*\(SELECT id FROM rpg\.phb_feat WHERE slug = '([^']+)'\),\s*'([^']+)',\s*'[^']*',\s*'(catalog|ability|spell|proficiency|fighting_style)'/g;
while ((m = defOptionKeyRe.exec(optionSqlCompact)) !== null) {
  const slug = m[1];
  const key = m[2];
  if (!defsBySlug.has(slug)) defsBySlug.set(slug, new Set());
  defsBySlug.get(slug).add(key);
}

// D006 ritual caster: colunas spell_ritual_only no INSERT
const ritualDefRe =
  /slug = 'ritual-caster'[^)]+\), 'abilityIncrease'/g;
if (ritualDefRe.test(optionSqlCompact)) {
  if (!defsBySlug.has('ritual-caster')) defsBySlug.set('ritual-caster', new Set());
  defsBySlug.get('ritual-caster').add('abilityIncrease');
}

const ritualDynamic = defsBySlug.has('ritual-caster');

/** @type {string[]} */
const covered = [];
/** @type {string[]} */
const ignoredCombat = [];
/** @type {{ slug: string; excerpt: string }[]} */
const gaps = [];

const seenSlugs = new Set();
for (const row of benefits) {
  if (seenSlugs.has(row.slug)) continue;
  seenSlugs.add(row.slug);

  if (COMBAT_TIME_SLUGS.has(row.slug)) {
    ignoredCombat.push(row.slug);
    continue;
  }

  if (defsBySlug.has(row.slug) && defsBySlug.get(row.slug).size > 0) {
    covered.push(row.slug);
    continue;
  }

  if (row.slug === 'ability-score-improvement' && defsBySlug.has(row.slug)) {
    covered.push(row.slug);
    continue;
  }

  gaps.push({ slug: row.slug, excerpt: row.excerpt });
}

covered.sort();
ignoredCombat.sort();
gaps.sort((a, b) => a.slug.localeCompare(b.slug));

const spellFeats = [
  'magic-initiate',
  'ritual-caster',
  'fey-touched',
  'shadow-touched',
  'telekinetic',
  'telepathic',
].map((slug) => ({
  slug,
  keys: [...(defsBySlug.get(slug) ?? [])].sort(),
}));

const lines = [];
lines.push('# Auditoria — opções de talentos (S022)');
lines.push('');
lines.push(`Gerado em ${new Date().toISOString().slice(0, 10)} por \`npm run db:audit:feat-options\`.`);
lines.push('');
lines.push('## Resumo');
lines.push('');
lines.push(`| Métrica | Valor |`);
lines.push(`| --- | --- |`);
lines.push(`| Benefícios com texto de escolha (S022) | ${seenSlugs.size} talentos |`);
lines.push(`| Com \`phb_feat_option_def\` (seeds S075+ / D002–D010) | ${covered.length} |`);
lines.push(`| Escolha só em combate/descanso (ignorados) | ${ignoredCombat.length} |`);
lines.push(`| Lacunas na criação de ficha | ${gaps.length} |`);
lines.push('');
lines.push('## Magias em talentos (tipo `spell` / ritual dinâmico)');
lines.push('');
for (const row of spellFeats) {
  const status = row.keys.length ? `\`${row.keys.join('`, `')}\`` : '—';
  lines.push(`- **${row.slug}**: ${status}${row.slug === 'ritual-caster' && ritualDynamic ? ' (+ slots `ritualSpell*` por BP na API)' : ''}`);
}
lines.push('');
lines.push('## Cobertos');
lines.push('');
for (const slug of covered) {
  const keys = [...(defsBySlug.get(slug) ?? [])].sort().join(', ');
  lines.push(`- [x] \`${slug}\`${keys ? ` — ${keys}` : ''}`);
}
lines.push('');
lines.push('## Ignorados (escolha situacional, sem opção na ficha)');
lines.push('');
for (const slug of ignoredCombat) {
  lines.push(`- [ ] \`${slug}\` — escolha no momento de uso`);
}
lines.push('');
lines.push('## Lacunas');
lines.push('');
if (gaps.length === 0) {
  lines.push('_Nenhuma lacuna mecânica na criação._');
} else {
  for (const gap of gaps) {
    lines.push(`- [ ] \`${gap.slug}\` — ${gap.excerpt}…`);
  }
}
lines.push('');
lines.push('## Fontes de defs');
lines.push('');
lines.push('- Seeds: `S075`–`S078` (S078 espelha D002–D010)');
lines.push('- Migrations: `database/migrations/050_data/D002`–`D010`');
lines.push('- ASI em massa: `D003` (gerado por `npm run db:generate:feat-asi`)');
lines.push('');

const outPath = path.join(root, 'docs/feat-options-audit.md');
fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
console.error(`Wrote ${outPath}`);
console.error(`Covered: ${covered.length}, gaps: ${gaps.length}, ignored: ${ignoredCombat.length}`);
