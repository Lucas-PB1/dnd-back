#!/usr/bin/env node
/**
 * Aplica seeds SQL (catálogo PHB + fontes).
 *
 * Uso:
 *   node scripts/run-seeds.mjs
 *   node scripts/run-seeds.mjs --target=supabase
 *   node scripts/run-seeds.mjs --from=thread/northlands/phb_character.threads.sql
 *   node scripts/run-seeds.mjs --from=thread/northlands/phb_character.threads.sql --skip-truncate
 *
 * Iteração: use DATABASE_URL=localhost (npm run db:up). Cloud só com --target=supabase.
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { assertLocalDatabaseUrl } from './lib/assert-local-db.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles } from './lib/sql-files.mjs';

loadEnv();

const seedsDir = path.join(rootDir, 'database/seeds');

const SEED_DOMAINS = [
  'catalog',
  'class',
  'subclass',
  'species',
  'feat',
  'transformation',
  'heritage',
  'thread',
  'background',
  'item',
  'spell',
  'economy',
  'creature',
  'effect',
];

/** @param {string} arg */
function parseTarget(arg) {
  const value = arg?.split('=')[1] ?? 'local';
  if (!['local', 'supabase', 'all'].includes(value)) {
    console.error(`Target inválido: ${value}. Use local, supabase ou all.`);
    process.exit(1);
  }
  return value;
}

/** @param {string | undefined} arg */
function parseFrom(arg) {
  if (!arg) return null;
  return arg.split('=')[1]?.replace(/\\/g, '/').replace(/^database\/seeds\//, '') ?? null;
}

function resolveTargets(target) {
  /** @type {{ label: string, url: string }[]} */
  const targets = [];

  if (target === 'local' || target === 'all') {
    const url = process.env.DATABASE_URL;
    if (!url) {
      console.error('DATABASE_URL não definida.');
      process.exit(1);
    }
    assertLocalDatabaseUrl(url, { label: 'db:seed local' });
    targets.push({ label: 'local', url });
  }

  if (target === 'supabase' || target === 'all') {
    const url = process.env.SUPABASE_DATABASE_URL;
    if (!url) {
      console.error('SUPABASE_DATABASE_URL não definida.');
      process.exit(1);
    }
    targets.push({ label: 'supabase', url });
  }

  return targets;
}

/** @returns {string[]} */
function listSeedFilesInOrder() {
  const files = [];
  const truncate = path.join(seedsDir, '000_truncate.sql');
  if (fs.existsSync(truncate)) files.push(truncate);

  const orderFile = path.join(seedsDir, 'SEED_ORDER.txt');
  if (fs.existsSync(orderFile)) {
    const lines = fs
      .readFileSync(orderFile, 'utf8')
      .split(/\r?\n/)
      .map((l) => l.trim())
      .filter((l) => l && !l.startsWith('#'));
    for (const rel of lines) {
      const abs = path.join(seedsDir, rel);
      if (!fs.existsSync(abs)) {
        console.warn(`  WARN SEED_ORDER missing: ${rel}`);
        continue;
      }
      files.push(abs);
    }
    return files;
  }

  for (const domain of SEED_DOMAINS) {
    const domainDir = path.join(seedsDir, domain);
    if (!fs.existsSync(domainDir)) continue;
    const sources = fs
      .readdirSync(domainDir, { withFileTypes: true })
      .filter((e) => e.isDirectory())
      .map((e) => e.name)
      .sort((a, b) => {
        if (a === 'phb' && b !== 'phb') return -1;
        if (b === 'phb' && a !== 'phb') return 1;
        return a < b ? -1 : a > b ? 1 : 0;
      });
    for (const source of sources) {
      files.push(...listSqlFiles(path.join(domainDir, source)));
    }
  }

  return files;
}

/**
 * @param {string[]} files
 * @param {string | null} fromRel
 * @param {boolean} skipTruncate
 */
function applyFromFilter(files, fromRel, skipTruncate) {
  let out = files;
  if (skipTruncate) {
    out = out.filter((f) => path.basename(f) !== '000_truncate.sql');
  }
  if (!fromRel) return out;

  const needle = fromRel.replace(/\\/g, '/');
  const idx = out.findIndex((f) => {
    const rel = path.relative(seedsDir, f).replace(/\\/g, '/');
    return rel === needle || rel.endsWith(needle) || f.replace(/\\/g, '/').endsWith(needle);
  });
  if (idx < 0) {
    console.error(`--from não encontrado na ordem: ${fromRel}`);
    process.exit(1);
  }
  console.log(`  resume from index ${idx}: ${path.relative(seedsDir, out[idx]).replace(/\\/g, '/')}`);
  return out.slice(idx);
}

/**
 * @param {string} label
 * @param {string} url
 * @param {{ fromRel: string | null, skipTruncate: boolean, skipRefresh: boolean }} opts
 */
async function seedOne(label, url, opts) {
  console.log(`\n→ ${maskDatabaseUrl(url)}`);

  const client = createPgClient(url);
  await client.connect();

  try {
    let files = listSeedFilesInOrder();
    files = applyFromFilter(files, opts.fromRel, opts.skipTruncate);

    for (const filePath of files) {
      const relative = path.relative(rootDir, filePath).replace(/\\/g, '/');
      const sql = fs.readFileSync(filePath, 'utf8');

      process.stdout.write(`  seeding ${relative}... `);
      await client.query(sql);
      console.log('ok');
    }

    if (!opts.skipRefresh) {
      const materializedViews = [
        'mv_spell_by_class',
        'mv_phb_feat',
        'mv_phb_background',
        'mv_phb_species_trait_choices',
        'mv_phb_class_economy_action',
        'mv_phb_creature_template_bundle',
        'mv_phb_vehicle_template_bundle',
        'mv_phb_character_thread_bundle',
        'mv_phb_hp_bonus_source',
        'mv_phb_unarmored_defense',
        'mv_class_spell_slots',
        'mv_subclass_spell_slots',
        'mv_phb_class_ability_boost',
        'mv_phb_feat_granted_spell',
        'mv_phb_class_granted_spell',
        'mv_phb_species_granted_spell',
        'mv_phb_heritage_trait_choices',
      ];
      for (const name of materializedViews) {
        process.stdout.write(`  refresh rpg.${name}... `);
        await client.query(`REFRESH MATERIALIZED VIEW CONCURRENTLY rpg.${name}`);
        console.log('ok');
      }
    }

    console.log(`  ${files.length} seed(s) aplicado(s)`);
  } finally {
    await client.end();
  }
}

const targetArg = process.argv.find((arg) => arg.startsWith('--target='));
const fromArg = process.argv.find((arg) => arg.startsWith('--from='));
const target = parseTarget(targetArg);
const fromRel = parseFrom(fromArg);
const skipTruncate = process.argv.includes('--skip-truncate');
const skipRefresh = process.argv.includes('--skip-refresh');
const targets = resolveTargets(target);

console.log(`Seeds — target: ${target}${fromRel ? ` from=${fromRel}` : ''}${skipTruncate ? ' (skip-truncate)' : ''}`);

for (const { label, url } of targets) {
  await seedOne(label, url, { fromRel, skipTruncate, skipRefresh });
}

console.log('\nConcluído.');
