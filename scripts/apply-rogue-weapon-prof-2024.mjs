import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Client } = require("../node_modules/pg");

const client = new Client({
  connectionString: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});
await client.connect();

const viewSql = fs.readFileSync(
  path.resolve("database/schema/030_views/0003_v_phb_weapon_proficiency.sql"),
  "utf8",
);
await client.query("DROP VIEW IF EXISTS rpg.v_phb_weapon_proficiency CASCADE");
await client.query(viewSql);
console.log("recreated v_phb_weapon_proficiency");

await client.query(`
  DELETE FROM rpg.phb_class_proficiency cp
  USING rpg.phb_class c
  WHERE cp.class_id = c.id
    AND c.slug = 'rogue'
    AND cp.kind = 'weapon'::rpg.class_proficiency_kind
`);

await client.query(`
  INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_slug)
  VALUES
    ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
    ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais-acuidade-ou-leves')
  ON CONFLICT DO NOTHING
`);

const check = await client.query(`
  SELECT cp.ref_slug
  FROM rpg.phb_class_proficiency cp
  JOIN rpg.phb_class c ON c.id = cp.class_id
  WHERE c.slug = 'rogue' AND cp.kind = 'weapon'::rpg.class_proficiency_kind
  ORDER BY cp.ref_slug
`);
console.log(
  "rogue weapon profs:",
  check.rows.map((r) => r.ref_slug).join(", "),
);

await client.end();
