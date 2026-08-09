/**
 * Aplica recursos de subclasse do Mago (C014).
 * Economia/painel: use reseed-c009 / reseed-c010.
 * Uso: node scripts/reseed-c014-wizard.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import "dotenv/config";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sql = fs.readFileSync(
  path.join(
    __dirname,
    "../database/seeds/combat/C014_wizard_subclass_resources.sql",
  ),
  "utf8",
);
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();
await client.query(sql);

const { rows: resources } = await client.query(
  `SELECT slug FROM rpg.phb_resource_definition
   WHERE slug IN ('third-eye', 'spectral-summon', 'illusory-self')
   ORDER BY 1`,
);

console.log("resources", resources);
await client.end();
