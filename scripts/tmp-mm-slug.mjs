import fs from "node:fs";
import pg from "pg";

const url = fs
  .readFileSync(".env", "utf8")
  .match(/^DATABASE_URL=(.+)$/m)[1]
  .trim()
  .replace(/^['"]|['"]$/g, "");
const c = new pg.Client({ connectionString: url });
await c.connect();
const r = await c.query(`
  select * from rpg.v_phb_subclass_prepared_spell
  where subclass_slug = 'magic-missile-mage'
`);
console.log("granted", r.rows);
await c.end();
