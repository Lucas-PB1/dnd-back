#!/usr/bin/env node
/**
 * Marca todas as migrations como aplicadas sem executar SQL.
 * Use quando o banco já foi populado via psql antes do runner existir.
 *
 *   node scripts/baseline-migrations.mjs
 *   node scripts/baseline-migrations.mjs --target=supabase
 *   node scripts/baseline-migrations.mjs --target=all
 */
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
      console.error('SUPABASE_DATABASE_URL não definida.');
      process.exit(1);
    }
    targets.push({ label: 'supabase', url });
  }

  return targets;
}

/**
 * @param {string} label
 * @param {string} url
 */
async function baselineOne(label, url) {
  console.log(`\n→ ${maskDatabaseUrl(url)}`);

  const client = createPgClient(url);
  await client.connect();

  try {
    await client.query(BOOTSTRAP_SQL);
    const files = listSqlFiles(migrationsDir);
    let inserted = 0;

    for (const filePath of files) {
      const version = migrationVersion(filePath, migrationsDir);
      const result = await client.query(
        `INSERT INTO rpg.schema_migration (version)
         VALUES ($1)
         ON CONFLICT (version) DO NOTHING
         RETURNING version`,
        [version],
      );
      if (result.rowCount > 0) inserted++;
    }

    console.log(`  ${inserted} versão(ões) registrada(s) (${files.length} no total)`);
  } finally {
    await client.end();
  }
}

const targetArg = process.argv.find((arg) => arg.startsWith('--target='));
const target = parseTarget(targetArg);
const targets = resolveTargets(target);

console.log(`Baseline migrations — target: ${target}`);

for (const { label, url } of targets) {
  await baselineOne(label, url);
}

console.log('\nConcluído.');
