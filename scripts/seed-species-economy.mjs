import "dotenv/config";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();

for (const rel of [
  "database/seeds/phb/S069_phb_species_resource_grant.sql",
  "database/seeds/combat/C011_phb_species_economy_action.sql",
]) {
  const sql = fs.readFileSync(path.join(__dirname, "..", rel), "utf8");
  await client.query(sql);
  console.log("ok", rel);
}

const grants = await client.query(
  `SELECT rd.slug, sp.slug AS species
   FROM rpg.phb_resource_grant g
   JOIN rpg.phb_resource_definition rd ON rd.id = g.resource_id
   JOIN rpg.phb_species sp ON sp.id = g.owner_id
   WHERE g.owner_kind = 'species'
   ORDER BY 2, 1`,
);
console.log("species grants", grants.rows.length, grants.rows);

const eco = await client.query(
  `SELECT action_id, species_slug, economy
   FROM rpg.v_phb_class_economy_action
   WHERE species_slug IS NOT NULL
   ORDER BY sort_order`,
);
console.log("species economy", eco.rows.length, eco.rows.map((r) => r.action_id));

await client.end();
