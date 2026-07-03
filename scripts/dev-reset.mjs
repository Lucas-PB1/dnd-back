#!/usr/bin/env node
/**
 * DROP SCHEMA rpg — apenas desenvolvimento local (DATABASE_URL).
 * Nunca roda em Supabase.
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida.');
  process.exit(1);
}

const resetPath = path.join(rootDir, 'database/dev-reset.sql');
const sql = fs.readFileSync(resetPath, 'utf8');

console.log(`Dev reset — ${maskDatabaseUrl(url)}`);
const client = createPgClient(url);
await client.connect();

try {
  await client.query(sql);
  console.log('Schema rpg recriado.');
} finally {
  await client.end();
}
