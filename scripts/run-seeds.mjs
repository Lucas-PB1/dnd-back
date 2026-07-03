#!/usr/bin/env node
/**
 * Aplica seeds SQL (catálogo PHB). Destrutivo se tabelas já tiverem dados — preferir após dev-reset.
 *
 * Uso:
 *   node scripts/run-seeds.mjs
 *   node scripts/run-seeds.mjs --target=supabase
 *   node scripts/run-seeds.mjs --target=all
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles } from './lib/sql-files.mjs';

loadEnv();

const seedsDir = path.join(rootDir, 'database/seeds');

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
async function seedOne(label, url) {
  console.log(`\n→ ${maskDatabaseUrl(url)}`);

  const client = createPgClient(url);
  await client.connect();

  try {
    const files = listSqlFiles(seedsDir);

    for (const filePath of files) {
      const relative = path.relative(rootDir, filePath).replace(/\\/g, '/');
      const sql = fs.readFileSync(filePath, 'utf8');

      process.stdout.write(`  seeding ${relative}... `);
      await client.query(sql);
      console.log('ok');
    }

    console.log(`  ${files.length} seed(s) aplicado(s)`);
  } finally {
    await client.end();
  }
}

const targetArg = process.argv.find((arg) => arg.startsWith('--target='));
const target = parseTarget(targetArg);
const targets = resolveTargets(target);

console.log(`Seeds — target: ${target}`);

for (const { label, url } of targets) {
  await seedOne(label, url);
}

console.log('\nConcluído.');
