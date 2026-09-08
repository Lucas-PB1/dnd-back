#!/usr/bin/env node
/**
 * Backfill pontual: Comum em todos os antecedentes + costume do smuggler.
 * Uso: node scripts/backfill-background-common-prod.mjs
 * Lê SUPABASE_DATABASE_URL de .env (sem wipe).
 */
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import fs from 'fs';
import path from 'path';

loadEnv();

const url = process.env.SUPABASE_DATABASE_URL;
if (!url) {
  console.error('SUPABASE_DATABASE_URL não definida.');
  process.exit(1);
}

const client = createPgClient(url, { preferPooler: true });
console.log(`→ ${maskDatabaseUrl(url, { preferPooler: true })}`);
await client.connect();

try {
  const langSql = fs.readFileSync(
    path.join(rootDir, 'database/seeds/background/phb/phb_background_language.all.sql'),
    'utf8',
  );
  await client.query(langSql);
  console.log('phb_background_language.all.sql ok');

  const costume = await client.query(`
    UPDATE rpg.phb_starting_item si
    SET item_id = (SELECT id FROM rpg.phb_item WHERE slug = 'roupas-fantasia')
    FROM rpg.phb_starting_package p
    JOIN rpg.phb_background b ON b.id = p.owner_id
    WHERE si.package_id = p.id
      AND p.source = 'background'
      AND b.slug = 'gh-syndicate-smuggler'
      AND p.slug = 'a'
      AND si.choice_text = 'Costume'
      AND si.item_id IS NULL
  `);
  console.log(`costume item_id rows: ${costume.rowCount}`);

  const missing = await client.query(`
    SELECT b.slug
    FROM rpg.phb_background b
    WHERE NOT EXISTS (
      SELECT 1
      FROM rpg.phb_background_language bl
      JOIN rpg.phb_language l ON l.id = bl.language_id
      WHERE bl.background_id = b.id AND l.slug = 'common'
    )
    ORDER BY b.slug
  `);
  console.log(
    'still missing common:',
    missing.rows.map((r) => r.slug),
  );

  const smuggler = await client.query(`
    SELECT l.slug
    FROM rpg.phb_background_language bl
    JOIN rpg.phb_background b ON b.id = bl.background_id
    JOIN rpg.phb_language l ON l.id = bl.language_id
    WHERE b.slug = 'gh-syndicate-smuggler'
  `);
  console.log('smuggler langs:', smuggler.rows.map((r) => r.slug));
} finally {
  await client.end();
}
