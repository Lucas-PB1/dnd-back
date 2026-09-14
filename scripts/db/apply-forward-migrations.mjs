/**
 * Aplica só migrations forward (database/migrations/) sem reaplicar schema.
 * Útil quando rpg já existe e schema declarative ganhou arquivos novos
 * espelhados por forward migrations.
 *
 * Uso: node scripts/db/apply-forward-migrations.mjs
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from '../lib/load-env.mjs';
import { assertLocalDatabaseUrl } from '../lib/assert-local-db.mjs';
import { createPgClient, maskDatabaseUrl } from '../lib/pg-client.mjs';
import { listSqlFiles, migrationVersion } from '../lib/sql-files.mjs';

loadEnv();

const migrationsDir = path.join(rootDir, 'database/migrations');
const schemaDir = path.join(rootDir, 'database/schema');
const databaseDir = path.join(rootDir, 'database');

const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida.');
  process.exit(1);
}
assertLocalDatabaseUrl(url, { label: 'apply-forward-migrations' });

const client = createPgClient(url);
console.log(`→ ${maskDatabaseUrl(url)}`);
await client.connect();

await client.query(`
CREATE SCHEMA IF NOT EXISTS rpg;
CREATE TABLE IF NOT EXISTS rpg.schema_migration (
  version TEXT PRIMARY KEY,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
`);

const applied = new Set(
  (await client.query('SELECT version FROM rpg.schema_migration')).rows.map(
    (r) => r.version,
  ),
);

let pending = 0;
for (const filePath of listSqlFiles(migrationsDir)) {
  if (filePath.includes(`${path.sep}_archive${path.sep}`)) continue;
  const version = migrationVersion(filePath, migrationsDir);
  if (applied.has(version)) continue;

  const relative = path.relative(rootDir, filePath).replace(/\\/g, '/');
  process.stdout.write(`  applying ${relative}... `);
  const sql = fs.readFileSync(filePath, 'utf8');
  await client.query('BEGIN');
  try {
    await client.query(sql);
    await client.query(
      'INSERT INTO rpg.schema_migration (version) VALUES ($1)',
      [version],
    );
    await client.query('COMMIT');
    console.log('ok');
    pending += 1;
  } catch (err) {
    await client.query('ROLLBACK');
    console.log('failed');
    throw err;
  }
}

// Marca schema files novos já cobertos por forward (evita assertSchemaSafe).
for (const filePath of listSqlFiles(schemaDir)) {
  const version = migrationVersion(filePath, databaseDir);
  if (applied.has(version)) continue;
  // Só marca se o objeto principal já existe (tabela do nome do arquivo).
  const base = path.basename(filePath, '.sql').replace(/^\d+_/, '');
  const tableCheck = await client.query(
    `SELECT to_regclass($1) AS reg`,
    [`rpg.${base}`],
  );
  if (!tableCheck.rows[0]?.reg) continue;
  await client.query(
    'INSERT INTO rpg.schema_migration (version) VALUES ($1) ON CONFLICT DO NOTHING',
    [version],
  );
  console.log(`  marked schema version ${version}`);
  applied.add(version);
}

console.log(pending === 0 ? 'Nada pendente (forward).' : `${pending} forward aplicada(s).`);
await client.end();
