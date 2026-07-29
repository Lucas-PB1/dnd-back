#!/usr/bin/env node
/**
 * DROP SCHEMA rpg — apenas desenvolvimento local (DATABASE_URL por padrão).
 * 
 * Uso:
 *   node scripts/dev-reset.mjs                  # DROP local
 *   node scripts/dev-reset.mjs --target=supabase # DROP Supabase (requer confirmação)
 */
import fs from 'fs';
import path from 'path';
import readline from 'readline/promises';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

/** @param {string} arg */
function parseTarget(arg) {
  const value = arg?.split('=')[1] ?? 'local';
  if (!['local', 'supabase'].includes(value)) {
    console.error(`Target inválido: ${value}. Use local ou supabase.`);
    process.exit(1);
  }
  return value;
}

async function confirmSupabaseReset() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  try {
    console.log('\n⚠️  ATENÇÃO: Você está prestes a DROPAR O SCHEMA rpg no Supabase!');
    console.log('⚠️  Esta operação é DESTRUTIVA e IRREVERSÍVEL.');
    console.log('\nPara confirmar, digite exatamente: CONFIRM_DROP_RPG=yes\n');
    
    const answer = await rl.question('Confirmação: ');
    if (answer.trim() !== 'CONFIRM_DROP_RPG=yes') {
      console.log('\n❌ Confirmação incorreta. Reset cancelado.');
      process.exit(0);
    }
  } finally {
    rl.close();
  }
}

const targetArg = process.argv.find((arg) => arg.startsWith('--target='));
const target = parseTarget(targetArg);

let url;
if (target === 'local') {
  url = process.env.DATABASE_URL;
  if (!url) {
    console.error('DATABASE_URL não definida.');
    process.exit(1);
  }
} else {
  url = process.env.SUPABASE_DATABASE_URL;
  if (!url) {
    console.error('SUPABASE_DATABASE_URL não definida.');
    process.exit(1);
  }
  const confirmedByFlag = process.argv.includes('--confirm');
  if (process.env.CONFIRM_DROP_RPG === 'yes' || confirmedByFlag) {
    console.log('Confirmação via CONFIRM_DROP_RPG=yes ou --confirm.');
  } else {
    await confirmSupabaseReset();
  }
}

const resetPath = path.join(rootDir, 'database/dev-reset.sql');
const sql = fs.readFileSync(resetPath, 'utf8');

console.log(`\nDev reset (${target}) — ${maskDatabaseUrl(url)}`);
const client = createPgClient(url);
await client.connect();

try {
  await client.query(sql);
  console.log('Schema rpg recriado.');
} finally {
  await client.end();
}
