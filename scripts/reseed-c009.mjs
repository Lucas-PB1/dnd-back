/**
 * Aplica só C009 (economia de ação) — upsert idempotente.
 * Uso: node scripts/reseed-c009.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import "dotenv/config";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sqlPath = path.join(
  __dirname,
  "../database/seeds/combat/C009_phb_class_economy_action.sql",
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
  SELECT action_id, economy::text, unlock_level, left(description, 48) AS desc_preview
  FROM rpg.phb_class_economy_action
  WHERE action_id LIKE 'wizard-mm%' OR action_id LIKE 'wizard-missile%' OR action_id LIKE 'wizard-giga%'
  ORDER BY sort_order
`);
console.table(rows);
await client.end();
