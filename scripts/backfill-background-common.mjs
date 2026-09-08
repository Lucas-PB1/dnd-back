import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Client } = require("../node_modules/pg");

const c = new Client({
  connectionString: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});
await c.connect();

const before = await c.query(
  `select count(*)::int as c
   from rpg.phb_background_language bl
   join rpg.phb_background b on b.id = bl.background_id
   where b.slug like 'gh-%'`,
);
console.log("gh fixed before", before.rows[0]);

const ins = await c.query(
  `INSERT INTO rpg.phb_background_language (background_id, language_id)
   SELECT b.id, l.id
   FROM rpg.phb_background b
   CROSS JOIN rpg.phb_language l
   WHERE l.slug = 'common'
   ON CONFLICT DO NOTHING
   RETURNING background_id`,
);
console.log("inserted rows", ins.rowCount);

const after = await c.query(
  `select count(*)::int as c
   from rpg.phb_background_language bl
   join rpg.phb_background b on b.id = bl.background_id
   where b.slug like 'gh-%'`,
);
console.log("gh fixed after", after.rows[0]);

const one = await c.query(
  `select l.slug
   from rpg.phb_background_language bl
   join rpg.phb_background b on b.id = bl.background_id
   join rpg.phb_language l on l.id = bl.language_id
   where b.slug = 'gh-free-swords-mercenary'`,
);
console.log("mercenary langs", one.rows);

const missing = await c.query(
  `select b.slug
   from rpg.phb_background b
   where not exists (
     select 1 from rpg.phb_background_language bl
     join rpg.phb_language l on l.id = bl.language_id
     where bl.background_id = b.id and l.slug = 'common'
   )
   order by b.slug`,
);
console.log(
  "still missing common",
  missing.rows.map((r) => r.slug),
);

await c.end();
