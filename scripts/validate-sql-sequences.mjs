#!/usr/bin/env node
/**
 * Valida layout SQL declarative: schema/** + seeds/{domínio}/{fonte}/{tabela}.{slug}.sql
 * Gates: sem ALTER/DROP em seeds; INSERT com ON CONFLICT (exceto truncate).
 * Uso: node scripts/validate-sql-sequences.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
let failed = false;

function fail(msg) {
  console.error(`FAIL: ${msg}`);
  failed = true;
}

function walkSql(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walkSql(p, out);
    else if (e.name.endsWith('.sql')) out.push(p);
  }
  return out;
}

const SEED_DOMAINS = new Set([
  'catalog',
  'class',
  'subclass',
  'species',
  'feat',
  'transformation',
  'heritage',
  'thread',
  'item',
  'spell',
  'background',
  'economy',
  'creature',
  'effect',
]);

const SEED_NAME_RE =
  /^[a-z][a-z0-9_]*(\.[a-z0-9][a-z0-9_-]*)+\.sql$/i;

const SCHEMA_NAME_RE = /^(\d{3}_[a-z0-9_]+\.sql|\d{3}_[a-z0-9_]+\/\d{3}_[a-z0-9_]+\.sql)$/i;

// --- schema ---
const schemaDir = path.join(root, 'database/schema');
if (!fs.existsSync(schemaDir)) {
  fail('database/schema/ missing');
} else {
  const schemaFiles = walkSql(schemaDir);
  if (schemaFiles.length < 10) {
    fail(`database/schema/ too few SQL files (${schemaFiles.length})`);
  }
  for (const filePath of schemaFiles) {
    const rel = path.relative(schemaDir, filePath).replace(/\\/g, '/');
    if (rel === '000_rpg_schema.sql') continue;
    const base = path.basename(filePath);
    if (!/^\d{3,4}_[a-z0-9_]+\.sql$/i.test(base)) {
      fail(`schema bad name: ${rel}`);
    }
  }
  console.log(`OK schema: ${schemaFiles.length} file(s)`);
}

// --- seeds ---
const seedsDir = path.join(root, 'database/seeds');
const truncate = path.join(seedsDir, '000_truncate.sql');
if (!fs.existsSync(truncate)) {
  fail('database/seeds/000_truncate.sql missing');
}

const seedFiles = walkSql(seedsDir).filter(
  (f) => path.basename(f) !== '000_truncate.sql',
);

for (const filePath of seedFiles) {
  const rel = path.relative(seedsDir, filePath).replace(/\\/g, '/');
  const parts = rel.split('/');
  if (parts.length !== 3) {
    fail(`seed path depth (want domain/source/file): ${rel}`);
    continue;
  }
  const [domain, source, file] = parts;
  if (!SEED_DOMAINS.has(domain)) {
    fail(`unknown seed domain "${domain}": ${rel}`);
  }
  if (!/^[a-z0-9][a-z0-9-]*$/i.test(source)) {
    fail(`bad seed source folder: ${rel}`);
  }
  if (!SEED_NAME_RE.test(file)) {
    fail(`seed bad name (want tabela.slug.sql): ${rel}`);
  }
  if (/^[A-Z]\d{3}/.test(file)) {
    fail(`opaque prefix still in seed name: ${rel}`);
  }

  const text = fs.readFileSync(filePath, 'utf8');
  if (/\bALTER\s+(TABLE|TYPE|SCHEMA|INDEX)\b/i.test(text)) {
    fail(`ALTER forbidden in seed: ${rel}`);
  }
  if (/\bDROP\s+(TABLE|TYPE|SCHEMA)\b/i.test(text)) {
    fail(`DROP TABLE/TYPE forbidden in seed: ${rel}`);
  }
  if (/\bDELETE\s+FROM\b/i.test(text)) {
    fail(`DELETE FROM forbidden in seed (use truncate + upsert): ${rel}`);
  }

  const hasInsert = /\bINSERT\b/i.test(text);
  const hasConflict = /\bON\s+CONFLICT\b/i.test(text);
  const truncateScoped = /seed-mode:\s*truncate-scoped/i.test(text);
  if (hasInsert && !hasConflict && !truncateScoped) {
    fail(`INSERT without ON CONFLICT: ${rel}`);
  }
}

// legacy packs must be gone
const legacyPacks = [
  'phb',
  'valdas',
  'combat',
  'effects',
  'grim-hollow',
  'creatures',
  'dmg',
  'valdas-gunslinger',
  'valdas-player-pack-2',
  'steinhardt-eldritch-hunt',
  'northlands-heroes',
  'griffons-saddlebag',
];
for (const pack of legacyPacks) {
  const p = path.join(seedsDir, pack);
  if (fs.existsSync(p) && fs.statSync(p).isDirectory()) {
    const still = walkSql(p);
    if (still.length) fail(`legacy pack still present: seeds/${pack} (${still.length} sql)`);
  }
}

console.log(`OK seeds: ${seedFiles.length} file(s) under domains`);

// stale string refs in tooling docs
const stale = [
  'database/baseline/001_full_schema',
  'apply-cap6-economy-seeds',
];

function walkDocs(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    if (e.name === 'node_modules' || e.name === 'dist') continue;
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walkDocs(p, out);
    else if (/\.(mjs|js|ts|md)$/.test(e.name) && !e.name.includes('reorganize-seeds') && !e.name.includes('split-baseline')) {
      out.push(p);
    }
  }
  return out;
}

// Only enforce stale after baseline removed — soft check on apply-*
for (const file of walkDocs(path.join(root, 'scripts')).concat(
  walkDocs(path.join(root, '.cursor/skills/postgres-apply-catalog')),
)) {
  const text = fs.readFileSync(file, 'utf8');
  if (text.includes('apply-cap6-economy-seeds') && !file.includes('validate-sql')) {
    // warn via fail only if file is not the apply script itself pending delete
    if (!file.includes('apply-cap6')) {
      fail(`stale apply-cap6 ref in ${path.relative(root, file)}`);
    }
  }
}

if (failed) {
  process.exit(1);
}
console.log('\nAll layout checks passed.');
