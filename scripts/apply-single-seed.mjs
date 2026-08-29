#!/usr/bin/env node
/**
 * Aplica um arquivo SQL de seed sem truncar o catálogo.
 *
 * Uso: node scripts/apply-single-seed.mjs database/seeds/phb/S080_phb_equipment_images.sql
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

const relative = process.argv[2];
if (!relative) {
  console.error('Uso: node scripts/apply-single-seed.mjs <caminho-relativo-ao-dnd-api>');
  process.exit(1);
}

const filePath = path.join(rootDir, relative);
if (!fs.existsSync(filePath)) {
  console.error(`Arquivo não encontrado: ${filePath}`);
  process.exit(1);
}

const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida.');
  process.exit(1);
}

const client = createPgClient(url);
await client.connect();
console.log(`Conectado: ${maskDatabaseUrl(url)}`);

const sql = fs.readFileSync(filePath, 'utf8');
await client.query(sql);
console.log(`ok — ${relative}`);

await client.end();
