/**
 * Aplica só C001 (manobras gunslinger) — upsert idempotente.
 * Uso: node scripts/reseed-c001.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import "dotenv/config";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sqlPath = path.join(
  __dirname,
  "../database/seeds/combat/C001_phb_gunslinger_maneuver.sql",
);
const sql = fs.readFileSync(sqlPath, "utf8");

const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();
try {
  await client.query("SET row_security = off");
} catch {
  /* ignore */
}
await client.query(sql);
const { rows } = await client.query(`
  SELECT m.slug, m.from_level, s.slug AS subclass_slug
  FROM rpg.phb_gunslinger_maneuver m
  LEFT JOIN rpg.phb_subclass s ON s.id = m.subclass_id
  WHERE s.slug IS NOT NULL
  ORDER BY s.slug, m.from_level, m.slug
`);
console.table(rows);
await client.end();
