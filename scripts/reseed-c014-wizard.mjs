/**
 * Aplica C014 (economia/painel/recursos das subclasses de Mago).
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
    "../database/seeds/combat/C014_wizard_subclass_economy_panel.sql",
  ),
  "utf8",
);
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();
await client.query(sql);

const { rows: economy } = await client.query(
  `SELECT action_id, unlock_level, economy::text
   FROM rpg.phb_class_economy_action
   WHERE action_id LIKE 'wizard-%'
     AND action_id NOT LIKE 'wizard-mm%'
     AND action_id NOT LIKE 'wizard-improved%'
     AND action_id NOT LIKE 'wizard-missile%'
     AND action_id NOT LIKE 'wizard-giga%'
   ORDER BY 1`,
);
const { rows: panels } = await client.query(
  `SELECT panel_key, unlock_level
   FROM rpg.phb_class_panel_action
   WHERE panel_key LIKE 'wizard%'
   ORDER BY 1`,
);
const { rows: resources } = await client.query(
  `SELECT slug FROM rpg.phb_resource_definition
   WHERE slug IN ('third-eye', 'spectral-summon', 'illusory-self')
   ORDER BY 1`,
);

console.log("economy", economy);
console.log("panels", panels);
console.log("resources", resources);
await client.end();
