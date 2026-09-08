import fs from "node:fs";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Client } = require("../node_modules/pg");

const client = new Client({
  connectionString: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});

await client.connect();

const mv = await client.query(
  "SELECT to_regclass('rpg.mv_phb_heritage_trait_choices') AS mv",
);
if (!mv.rows[0].mv) {
  await client.query(`
    CREATE MATERIALIZED VIEW rpg.mv_phb_heritage_trait_choices AS
    SELECT * FROM rpg.v_phb_heritage_trait_choices
  `);
  console.log("recreated mv_phb_heritage_trait_choices");
} else {
  await client.query(
    "REFRESH MATERIALIZED VIEW rpg.mv_phb_heritage_trait_choices",
  );
  console.log("refreshed mv_phb_heritage_trait_choices");
}

const rows = await client.query(`
  SELECT choice_kind, trait_slug, trait_name, label
  FROM rpg.v_phb_heritage_trait_choices
  WHERE choice_kind IN ('heritage_size', 'heritage_speed_trade')
  ORDER BY choice_kind, trait_slug
`);
for (const row of rows.rows) {
  console.log(
    row.choice_kind,
    row.trait_slug,
    "=>",
    row.trait_name,
    "/",
    row.label,
  );
}

await client.end();
