/**
 * Lista gaps de spellTables Cap.2 vs SPELL_SLUG_MAP / Cap.7 / J029.
 * Uso: node scripts/audit-ghpg-cap2-spell-grants.mjs
 */
import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';
import { SPELL_SLUG_MAP } from './lib/ghpg-cap2-spell-slug-map.mjs';

const cap2 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap2SubclassesEn, 'utf8'));
const cap7 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap7Spells, 'utf8'));
const j029 = fs.readFileSync(
  'database/seeds/grim-hollow/J029_phb_subclass_prepared_spell.sql',
  'utf8',
);

const cap7ByName = new Map(cap7.spells.map((s) => [s.name.toLowerCase(), s.slug]));
const cap7BySlug = new Set(cap7.spells.map((s) => s.slug));

const GAP_SLUGS = [
  'occultist-guild',
  'collegeof-fools',
  'collegeof-requiems',
  'circleof-mutation',
  'pathofthe-primal-spirit',
  'pathofthe-wrathful-dead',
  'sanguine-thief',
  'highway-rider',
  'wretched-bloodline-sorcery',
  'the-parasite-patron',
  'warriorofthe-leaden-crown',
];

function resolveSpell(name) {
  if (SPELL_SLUG_MAP[name]) {
    return { slug: SPELL_SLUG_MAP[name], source: 'phb-map' };
  }
  const gh = cap7ByName.get(name.toLowerCase());
  if (gh) return { slug: gh, source: 'cap7' };
  // fuzzy: ignore punctuation
  const norm = name.toLowerCase().replace(/[^a-z0-9]+/g, ' ').trim();
  for (const [n, slug] of cap7ByName) {
    if (n.replace(/[^a-z0-9]+/g, ' ').trim() === norm) {
      return { slug, source: 'cap7-fuzzy' };
    }
  }
  return { slug: null, source: null };
}

const report = [];
for (const slug of GAP_SLUGS) {
  const sc = (cap2.subclasses ?? []).find((s) => s.slug === slug);
  const inJ029 = j029.includes(`'${slug}'`);
  const tables = sc?.spellTables ?? [];
  const rows = [];
  for (const table of tables) {
    for (const row of table.rows ?? []) {
      for (const name of row.spells ?? []) {
        const r = resolveSpell(name);
        rows.push({ level: row.level, name, ...r });
      }
    }
  }
  report.push({
    slug,
    hasSpellTables: tables.length > 0,
    tableCount: tables.length,
    spellNameCount: rows.length,
    inJ029,
    unresolved: rows.filter((r) => !r.slug).map((r) => `L${r.level}:${r.name}`),
    resolved: rows.filter((r) => r.slug).map((r) => `L${r.level}:${r.name}->${r.slug}(${r.source})`),
  });
}

console.log(JSON.stringify(report, null, 2));

// Also: all subclasses with spellTables that have unresolved names
const allGaps = [];
for (const sc of cap2.subclasses ?? []) {
  for (const table of sc.spellTables ?? []) {
    for (const row of table.rows ?? []) {
      for (const name of row.spells ?? []) {
        const r = resolveSpell(name);
        if (!r.slug) allGaps.push(`${sc.slug} L${row.level}: ${name}`);
      }
    }
  }
}
console.log('\nALL unresolved spell names across Cap2:', allGaps.length);
console.log(allGaps.slice(0, 80).join('\n'));
