#!/usr/bin/env node
/**
 * Seeds via TypeORM DataSource + ledger rpg.seed_migration (checksum).
 *
 * Uso:
 *   node scripts/db/run-seeds.mjs
 *   node scripts/db/run-seeds.mjs --fresh
 *   node scripts/db/run-seeds.mjs --status
 *   node scripts/db/run-seeds.mjs --target=supabase
 *   node scripts/db/run-seeds.mjs --from=thread/northlands/phb_character.threads.sql
 */
import { spawnSync } from 'child_process';
import path from 'path';
import { loadEnv, rootDir } from '../lib/load-env.mjs';
import { assertLocalDatabaseUrl } from '../lib/assert-local-db.mjs';
import { maskDatabaseUrl } from '../lib/pg-client.mjs';

loadEnv();

const CLI = path.join(rootDir, 'src/database/run-seeds-cli.ts');
const TS_NODE = path.join(
  rootDir,
  'node_modules/ts-node/register/transpile-only.js',
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

/**
 * @param {string} url
 * @param {string} label
 * @param {string[]} passthrough
 */
function runCli(url, label, passthrough) {
  console.log(`\n→ [${label}] ${maskDatabaseUrl(url)}`);
  const result = spawnSync(
    process.execPath,
    ['--require', TS_NODE, CLI, ...passthrough],
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
  if (result.status !== 0) process.exit(result.status ?? 1);
}

const argv = process.argv.slice(2);
const targetArg = argv.find((a) => a.startsWith('--target='));
const passthrough = argv.filter((a) => !a.startsWith('--target='));
const target = parseTarget(targetArg);
const targets = resolveTargets(target);
const mode = passthrough.includes('--status')
  ? 'status'
  : passthrough.includes('--fresh')
    ? 'fresh'
    : 'pending';

console.log(`Seeds (${mode}) — target: ${target}`);

for (const { label, url } of targets) {
  runCli(url, label, passthrough);
}

console.log('\nConcluído.');
