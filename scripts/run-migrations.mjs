#!/usr/bin/env node
/**
 * Aplica baseline + migrations forward-only pendentes.
 *
 * Uso:
 *   node scripts/run-migrations.mjs                 # DATABASE_URL
 *   node scripts/run-migrations.mjs --target=supabase
 *   node scripts/run-migrations.mjs --target=all
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles, migrationVersion } from './lib/sql-files.mjs';

loadEnv();

const baselineDir = path.join(rootDir, 'database/baseline');
const migrationsDir = path.join(rootDir, 'database/migrations');
const BASELINE_VERSION = 'baseline/001_full_schema';

const BOOTSTRAP_SQL = `
CREATE SCHEMA IF NOT EXISTS rpg;

CREATE TABLE IF NOT EXISTS rpg.schema_migration (
  version TEXT PRIMARY KEY,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
`;

/** @param {string} arg */
function parseTarget(arg) {
  const value = arg?.split('=')[1] ?? 'local';
  if (!['local', 'supabase', 'all'].includes(value)) {
    console.error(`Target inválido: ${value}. Use local, supabase ou all.`);
    process.exit(1);
  }
  return value;
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
    targets.push({ label: 'local', url });
  }

  if (target === 'supabase' || target === 'all') {
    const url = process.env.SUPABASE_DATABASE_URL;
    if (!url) {
      console.error(
        'SUPABASE_DATABASE_URL não definida. Use a connection string direct (porta 5432) do dashboard Supabase.',
      );
      process.exit(1);
    }
    targets.push({ label: 'supabase', url });
  }

  return targets;
}

/**
 * Baseline primeiro; depois forward-only em database/migrations/ (_archive ignorado).
 * @returns {{ filePath: string, version: string }[]}
 */
function collectMigrationFiles() {
  /** @type {{ filePath: string, version: string }[]} */
  const entries = [];

  if (fs.existsSync(baselineDir)) {
    const databaseDir = path.join(rootDir, 'database');
    for (const filePath of listSqlFiles(baselineDir)) {
      entries.push({
        filePath,
        version: migrationVersion(filePath, databaseDir),
      });
    }
  }

  if (fs.existsSync(migrationsDir)) {
    for (const filePath of listSqlFiles(migrationsDir)) {
      if (filePath.includes(`${path.sep}_archive${path.sep}`)) continue;
      entries.push({
        filePath,
        version: migrationVersion(filePath, migrationsDir),
      });
    }
  }

  return entries;
}

/** @param {import('pg').Client} client */
async function ensureMigrationTable(client) {
  await client.query(BOOTSTRAP_SQL);
}

/** @param {import('pg').Client} client */
async function getAppliedVersions(client) {
  const result = await client.query(
    'SELECT version FROM rpg.schema_migration ORDER BY version',
  );
  return new Set(result.rows.map((row) => row.version));
}

/**
 * Baseline exige schema vazio ou reset — não aplicar sobre migrations granulares antigas.
 * @param {import('pg').Client} client
 * @param {Set<string>} applied
 * @param {{ filePath: string, version: string }[]} files
 */
async function assertBaselineSafe(client, applied, files) {
  const baselinePending = files.some(
    ({ version }) => version === BASELINE_VERSION && !applied.has(BASELINE_VERSION),
  );
  if (!baselinePending) return;

  const catalog = await client.query(`
    SELECT EXISTS (
      SELECT 1 FROM information_schema.tables
      WHERE table_schema = 'rpg' AND table_name = 'phb_edition'
    ) AS has_catalog
  `);
  if (!catalog.rows[0]?.has_catalog) return;

  console.error(`
  Baseline pendente, mas o schema rpg já existe.

  Rode reset antes de migrar:
    npm run db:reset                  # local
    npm run db:setup:all              # local + Supabase (wipe + baseline + seed)

  Ou, só Supabase: CONFIRM_DROP_RPG=yes node scripts/dev-reset.mjs --target=supabase --confirm
`);
  process.exit(1);
}

/**
 * @param {import('pg').Client} client
 * @param {string} label
 * @param {string} url
 */
async function migrateOne(label, url) {
  const preferPooler =
    process.env.SUPABASE_MIGRATIONS_USE_POOLER === '1' ||
    process.env.SUPABASE_MIGRATIONS_USE_POOLER === 'true';

  let client = createPgClient(url, { preferPooler });
  console.log(`\n→ ${maskDatabaseUrl(url, { preferPooler })}`);

  try {
    await client.connect();
  } catch (err) {
    const code = err && typeof err === 'object' && 'code' in err ? err.code : '';
    const isDirectHost = /db\.[^.]+\.supabase\.co/i.test(
      maskDatabaseUrl(url),
    );
    if (!preferPooler && isDirectHost && code === 'ENOTFOUND') {
      console.log(
        '  db.* inacessível (ENOTFOUND); tentando session pooler…',
      );
      client = createPgClient(url, { preferPooler: true });
      console.log(`→ ${maskDatabaseUrl(url, { preferPooler: true })}`);
      await client.connect();
    } else {
      throw err;
    }
  }

  try {
    await ensureMigrationTable(client);
    const applied = await getAppliedVersions(client);
    const files = collectMigrationFiles();
    await assertBaselineSafe(client, applied, files);
    let pending = 0;

    for (const { filePath, version } of files) {
      if (applied.has(version)) continue;

      const sql = fs.readFileSync(filePath, 'utf8');
      const relativeFromRoot = path.relative(rootDir, filePath).replace(/\\/g, '/');

      process.stdout.write(`  applying ${relativeFromRoot}... `);
      await client.query('BEGIN');
      try {
        await client.query(sql);
        await client.query(
          'INSERT INTO rpg.schema_migration (version) VALUES ($1)',
          [version],
        );
        await client.query('COMMIT');
        console.log('ok');
        pending++;
      } catch (err) {
        await client.query('ROLLBACK');
        console.log('failed');
        throw err;
      }
    }

    if (pending === 0) {
      console.log('  nenhuma migration pendente');
    } else {
      console.log(`  ${pending} migration(s) aplicada(s)`);
    }
  } finally {
    await client.end();
  }
}

const targetArg = process.argv.find((arg) => arg.startsWith('--target='));
const target = parseTarget(targetArg);
const targets = resolveTargets(target);

console.log(`Migrations — target: ${target}`);

for (const { label, url } of targets) {
  await migrateOne(label, url);
}

console.log('\nConcluído.');
