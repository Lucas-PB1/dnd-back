#!/usr/bin/env node
/**
 * Aplica schema declarative (database/schema/**) + migrations forward-only pendentes.
 *
 * Uso:
 *   node scripts/db/run-migrations.mjs                 # DATABASE_URL
 *   node scripts/db/run-migrations.mjs --target=supabase
 *   node scripts/db/run-migrations.mjs --target=all
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from '../lib/load-env.mjs';
import { assertLocalDatabaseUrl } from '../lib/assert-local-db.mjs';
import { createPgClient, maskDatabaseUrl } from '../lib/pg-client.mjs';
import { listSqlFiles, migrationVersion } from '../lib/sql-files.mjs';

loadEnv();

const schemaDir = path.join(rootDir, 'database/schema');
const legacyBaselineDir = path.join(rootDir, 'database/baseline');
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
    assertLocalDatabaseUrl(url, { label: 'db:migrate local' });
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
 * Schema declarative primeiro; depois forward-only em database/migrations/.
 * @returns {{ filePath: string, version: string }[]}
 */
function collectMigrationFiles() {
  /** @type {{ filePath: string, version: string }[]} */
  const entries = [];
  const databaseDir = path.join(rootDir, 'database');

  if (fs.existsSync(schemaDir)) {
    for (const filePath of listSqlFiles(schemaDir)) {
      entries.push({
        filePath,
        version: migrationVersion(filePath, databaseDir),
      });
    }
  } else if (fs.existsSync(legacyBaselineDir)) {
    for (const filePath of listSqlFiles(legacyBaselineDir)) {
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
 * Schema exige rpg vazio ou reset — não aplicar sobre catálogo antigo sem wipe.
 * @param {import('pg').Client} client
 * @param {Set<string>} applied
 * @param {{ filePath: string, version: string }[]} files
 */
async function assertSchemaSafe(client, applied, files) {
  const schemaPending = files.some(
    ({ version }) =>
      (version.startsWith('schema/') || version.startsWith('baseline/')) &&
      !applied.has(version),
  );
  if (!schemaPending) return;

  const catalog = await client.query(`
    SELECT EXISTS (
      SELECT 1 FROM information_schema.tables
      WHERE table_schema = 'rpg' AND table_name = 'phb_edition'
    ) AS has_catalog
  `);
  if (!catalog.rows[0]?.has_catalog) return;

  console.error(`
  Schema pendente, mas o schema rpg já existe.

  Rode reset antes de migrar:
    npm run db:reset                  # local
    npm run db:setup:all              # local + Supabase (wipe + schema + seed)

  Ou, só Supabase: CONFIRM_DROP_RPG=yes node scripts/db/dev-reset.mjs --target=supabase --confirm
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
    const isDirectHost = /db\.[^.]+\.supabase\.co/i.test(maskDatabaseUrl(url));
    if (!preferPooler && isDirectHost && code === 'ENOTFOUND') {
      console.log('  db.* inacessível (ENOTFOUND); tentando session pooler…');
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
    await assertSchemaSafe(client, applied, files);
    let pending = 0;

    const schemaFiles = files.filter(
      ({ version }) =>
        version.startsWith('schema/') || version.startsWith('baseline/'),
    );
    const forwardFiles = files.filter(
      ({ version }) =>
        !version.startsWith('schema/') && !version.startsWith('baseline/'),
    );

    for (const { filePath, version } of schemaFiles) {
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

    const tableExists = await client.query(`
      SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'rpg' AND table_name = 'phb_class'
      ) AS ok
    `);
    let hasCatalogRows = false;
    if (tableExists.rows[0]?.ok) {
      const classRows = await client.query(
        'SELECT EXISTS (SELECT 1 FROM rpg.phb_class LIMIT 1) AS ok',
      );
      hasCatalogRows = Boolean(classRows.rows[0]?.ok);
    }
    const pendingForward = forwardFiles.filter(({ version }) => !applied.has(version));

    if (pendingForward.length > 0 && !hasCatalogRows) {
      console.log(
        `  ${pendingForward.length} forward migration(s) adiadas — rode npm run db:seed e depois npm run db:migrate`,
      );
    } else {
      for (const { filePath, version } of pendingForward) {
        const sql = fs.readFileSync(filePath, 'utf8');
        const relativeFromRoot = path
          .relative(rootDir, filePath)
          .replace(/\\/g, '/');

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
    }

    if (pending === 0 && (hasCatalogRows || pendingForward.length === 0)) {
      console.log('  nenhuma migration pendente');
    } else if (pending > 0) {
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
