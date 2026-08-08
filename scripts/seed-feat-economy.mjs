import "dotenv/config";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();

for (const rel of [
  "database/seeds/phb/S071_phb_feat_resource_grant.sql",
  "database/seeds/combat/C012_phb_feat_economy_action.sql",
]) {
  const sql = fs.readFileSync(path.join(__dirname, "..", rel), "utf8");
  await client.query(sql);
  console.log("ok", rel);
}

const grants = await client.query(
  `SELECT rd.slug, f.slug AS feat
   FROM rpg.phb_resource_grant g
   JOIN rpg.phb_resource_definition rd ON rd.id = g.resource_id
   JOIN rpg.phb_feat f ON f.id = g.owner_id
   WHERE g.owner_kind = 'feat'
   ORDER BY 2, 1`,
);
console.log("feat grants", grants.rows.length, grants.rows);

const eco = await client.query(
  `SELECT action_id, feat_slug, economy
   FROM rpg.v_phb_class_economy_action
   WHERE feat_slug IS NOT NULL
   ORDER BY sort_order`,
);
console.log("feat economy", eco.rows.length, eco.rows.map((r) => r.action_id));

await client.end();
