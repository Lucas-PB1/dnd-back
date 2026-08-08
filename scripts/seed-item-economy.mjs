import "dotenv/config";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();

for (const rel of [
  "database/seeds/phb/S072_phb_item_resource_grant.sql",
  "database/seeds/combat/C013_phb_item_economy_action.sql",
]) {
  const sql = fs.readFileSync(path.join(__dirname, "..", rel), "utf8");
  await client.query(sql);
  console.log("ok", rel);
}

const grants = await client.query(
  `SELECT rd.slug, i.slug AS item
   FROM rpg.phb_resource_grant g
   JOIN rpg.phb_resource_definition rd ON rd.id = g.resource_id
   JOIN rpg.phb_item i ON i.id = g.owner_id
   WHERE g.owner_kind = 'item'
   ORDER BY 2, 1`,
);
console.log("item grants", grants.rows.length, grants.rows);

const eco = await client.query(
  `SELECT action_id, item_slug, economy
   FROM rpg.v_phb_class_economy_action
   WHERE item_slug IS NOT NULL
   ORDER BY sort_order`,
);
console.log("item economy", eco.rows.length, eco.rows.map((r) => r.action_id));

await client.end();
