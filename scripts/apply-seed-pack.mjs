#!/usr/bin/env node
/**
 * Aplica um pack de seeds sem truncate.
 * Uso: node scripts/apply-seed-pack.mjs grim-hollow --target=supabase
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles } from './lib/sql-files.mjs';

loadEnv();

const pack = process.argv[2];
const targetArg = process.argv.find((a) => a.startsWith('--target='));
const target = targetArg?.split('=')[1] ?? 'supabase';

if (!pack) {
  console.error('Uso: node scripts/apply-seed-pack.mjs <pack> [--target=supabase|local]');
  process.exit(1);
}

const url =
  target === 'local' ? process.env.DATABASE_URL : process.env.SUPABASE_DATABASE_URL;
if (!url) {
  console.error(`URL não definida para target=${target}`);
  process.exit(1);
}

const packDir = path.join(rootDir, 'database/seeds', pack);
if (!fs.existsSync(packDir)) {
  console.error(`Pack não encontrado: ${packDir}`);
  process.exit(1);
}

const client = createPgClient(url);
await client.connect();
console.log(`Pack ${pack} → ${maskDatabaseUrl(url)}`);

try {
  for (const file of listSqlFiles(packDir)) {
    const rel = path.relative(rootDir, file).replace(/\\/g, '/');
    process.stdout.write(`  ${rel}... `);
    await client.query(fs.readFileSync(file, 'utf8'));
    console.log('ok');
  }
} finally {
  await client.end();
}

console.log('Concluído.');
