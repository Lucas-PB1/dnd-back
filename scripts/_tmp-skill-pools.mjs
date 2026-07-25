#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import pg from 'pg';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const envPath = path.join(root, '.env');
for (const line of fs.readFileSync(envPath, 'utf8').split('\n')) {
  const m = line.match(/^DATABASE_URL=(.*)$/);
  if (m) process.env.DATABASE_URL = m[1].replace(/^["']|["']$/g, '');
}

const client = new pg.Client({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
});
await client.connect();
const pools = await client.query(
  `select class_slug, count(*)::int as n from rpg.v_phb_class_skill_choice group by 1 order by 1`,
);
console.table(pools.rows);
const bard = await client.query(
  `select slug, skill_choice_count, skill_choice_from from rpg.phb_class where slug = 'bard'`,
);
console.log(bard.rows);
await client.end();
