#!/usr/bin/env node
/**
 * Wrapper TypeORM CLI com --target=local|supabase|all.
 *
 * Uso:
 *   node scripts/db/run-typeorm.mjs migration:run
 *   node scripts/db/run-typeorm.mjs migration:show --target=supabase
 *   node scripts/db/run-typeorm.mjs migration:create src/database/migrations/Nome
 *   node scripts/db/run-typeorm.mjs migration:generate src/database/migrations/Nome
 */
import { spawnSync } from 'child_process';
import path from 'path';
import { loadEnv, rootDir } from '../lib/load-env.mjs';
import { assertLocalDatabaseUrl } from '../lib/assert-local-db.mjs';
import { createPgClient, maskDatabaseUrl } from '../lib/pg-client.mjs';

loadEnv();

const DATA_SOURCE = path.join(rootDir, 'src/database/data-source.ts');
const TYPEORM_BIN = path.join(
  rootDir,
  'node_modules/typeorm/cli-ts-node-commonjs.js',
);

/** @param {string | undefined} arg */
function parseTarget(arg) {
  const value = arg?.split('=')[1] ?? 'local';
  if (!['local', 'supabase', 'all'].includes(value)) {
    console.error(`Target inválido: ${value}. Use local, supabase ou all.`);
    process.exit(1);
  }
  return value;
}

/** @param {string} target */
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
 * @param {string} url
 * @param {string} label
 */
async function ensureRpgSchema(url, label) {
  const preferPooler =
    process.env.SUPABASE_MIGRATIONS_USE_POOLER === '1' ||
    process.env.SUPABASE_MIGRATIONS_USE_POOLER === 'true';

  let client = createPgClient(url, { preferPooler });
  try {
    await client.connect();
  } catch (err) {
    const code =
      err && typeof err === 'object' && 'code' in err ? err.code : '';
    const isDirectHost = /db\.[^.]+\.supabase\.co/i.test(
      maskDatabaseUrl(url),
    );
    if (!preferPooler && isDirectHost && code === 'ENOTFOUND') {
      client = createPgClient(url, { preferPooler: true });
      await client.connect();
    } else {
      throw err;
    }
  }

  try {
    await client.query('CREATE SCHEMA IF NOT EXISTS rpg');
  } finally {
    await client.end();
  }
  console.log(`  [${label}] schema rpg ok`);
}

/**
 * @param {string[]} typeormArgs
 * @param {string} url
 * @param {string} label
 */
function runTypeormCli(typeormArgs, url, label) {
  console.log(`\n→ [${label}] ${maskDatabaseUrl(url)}`);

  const result = spawnSync(
    process.execPath,
    [TYPEORM_BIN, ...typeormArgs, '-d', DATA_SOURCE],
    {
      cwd: rootDir,
      env: { ...process.env, DATABASE_URL: url },
      stdio: 'inherit',
    },
  );

  if (result.error) {
    console.error(result.error);
    process.exit(1);
  }
  if (result.status !== 0) {
    process.exit(result.status ?? 1);
  }
}

/**
 * @param {string} command
 * @param {string[]} rest
 * @param {string | undefined} targetArg
 */
async function runPathCommand(command, rest, targetArg) {
  const pathArg = rest.find((a) => !a.startsWith('-'));
  if (!pathArg) {
    const npmCmd =
      command === 'migration:create' ? 'create' : 'generate';
    console.error(
      `Uso: npm run db:migration:${npmCmd} -- src/database/migrations/Nome`,
    );
    process.exit(1);
  }

  if (command === 'migration:create') {
    const result = spawnSync(
      process.execPath,
      [TYPEORM_BIN, 'migration:create', pathArg],
      { cwd: rootDir, env: process.env, stdio: 'inherit' },
    );
    if (result.status !== 0) process.exit(result.status ?? 1);
    return;
  }

  const target = parseTarget(targetArg);
  const { url, label } = resolveTargets(target)[0];
  await ensureRpgSchema(url, label);
  runTypeormCli(['migration:generate', pathArg], url, label);
}

const argv = process.argv.slice(2);
const targetArg = argv.find((a) => a.startsWith('--target='));
const args = argv.filter((a) => !a.startsWith('--target='));
const [command, ...rest] = args;

if (!command) {
  console.error(
    'Comando ausente. Use migration:run | migration:show | migration:create | migration:generate | migration:revert',
  );
  process.exit(1);
}

if (command === 'migration:create' || command === 'migration:generate') {
  await runPathCommand(command, rest, targetArg);
} else if (
  command === 'migration:run' ||
  command === 'migration:show' ||
  command === 'migration:revert'
) {
  const target = parseTarget(targetArg);
  const targets = resolveTargets(target);
  console.log(`TypeORM ${command} — target: ${target}`);

  for (const { label, url } of targets) {
    await ensureRpgSchema(url, label);
    runTypeormCli([command], url, label);
  }
  console.log('\nConcluído.');
} else {
  console.error(`Comando TypeORM não suportado no wrapper: ${command}`);
  process.exit(1);
}
