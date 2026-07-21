#!/usr/bin/env node
/**
 * Gera database/seeds/phb/S078_phb_feat_option_data.sql a partir de D002–D010.
 * Idempotente (ON CONFLICT) — alinha db:seed com migrations 050_data.
 *
 * Uso: node scripts/sync-feat-option-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const migrationsDir = path.join(root, 'database/migrations/050_data');
const outPath = path.join(root, 'database/seeds/phb/S078_phb_feat_option_data.sql');

const files = fs
  .readdirSync(migrationsDir)
  .filter((name) => /^D00[2-9]|^D010_/.test(name) && name.endsWith('.sql'))
  .sort();

const chunks = [
  '-- Seed rpg.phb_feat_option_* — espelha migrations 050_data D002–D010',
  '-- Regenerar: npm run db:sync:feat-option-seeds',
  '-- Idempotente após db:migrate (ON CONFLICT / UPDATE seguros)',
  '',
];

for (const name of files) {
  const sql = fs.readFileSync(path.join(migrationsDir, name), 'utf8').trim();
  chunks.push(`-- --- ${name} ---`);
  chunks.push(sql);
  chunks.push('');
}

fs.writeFileSync(outPath, chunks.join('\n') + '\n', 'utf8');
console.error(`Wrote ${path.relative(root, outPath)} (${files.length} migration files)`);
