#!/usr/bin/env node
/**
 * Aplica migrations pendentes em um ou mais bancos PostgreSQL.
 *
 * Uso:
 *   node scripts/run-migrations.mjs                 # DATABASE_URL
 *   node scripts/run-migrations.mjs --target=supabase
 *   node scripts/run-migrations.mjs --phase=data     # só 050_data (após db:seed)
 *   node scripts/run-migrations.mjs --phase=schema   # sem 050_data
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles, migrationVersion } from './lib/sql-files.mjs';

loadEnv();

const migrationsDir = path.join(rootDir, 'database/migrations');

const BOOTSTRAP_SQL = `
CREATE SCHEMA IF NOT EXISTS rpg;

CREATE TABLE IF NOT EXISTS rpg.schema_migration (
  version TEXT PRIMARY KEY,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
`;

/** @param {string} arg */
function parsePhase(arg) {
  const value = arg?.split('=')[1] ?? 'all';
  if (!['all', 'schema', 'data'].includes(value)) {
    console.error(`Phase inválida: ${value}. Use all, schema ou data.`);
    process.exit(1);
  }
  return value;
}

/** @param {string} relativePath from migrations dir */
function includeMigrationFile(relativePath, phase) {
  const isData = relativePath.includes('/050_data/') || relativePath.startsWith('050_data/');
  if (phase === 'schema') return !isData;
  if (phase === 'data') return isData;
  return true;
}

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
 * @param {import('pg').Client} client
 * @param {string} label
 * @param {string} url
 */
async function migrateOne(label, url, phase) {
  console.log(`\n→ ${maskDatabaseUrl(url)}`);

  const client = createPgClient(url);
  await client.connect();

  try {
    await ensureMigrationTable(client);
    const applied = await getAppliedVersions(client);
    const files = listSqlFiles(migrationsDir);
    let pending = 0;

    for (const filePath of files) {
      const version = migrationVersion(filePath, migrationsDir);
      const relative = path.relative(migrationsDir, filePath).replace(/\\/g, '/');
      if (!includeMigrationFile(relative, phase)) continue;
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
const phaseArg = process.argv.find((arg) => arg.startsWith('--phase='));
const target = parseTarget(targetArg);
const phase = parsePhase(phaseArg);
const targets = resolveTargets(target);

console.log(`Migrations — target: ${target}, phase: ${phase}`);

for (const { label, url } of targets) {
  await migrateOne(label, url, phase);
}

console.log('\nConcluído.');
