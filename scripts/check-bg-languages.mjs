import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Client } = require("../node_modules/pg");

const c = new Client({
  connectionString: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});
await c.connect();

const phb = await c.query(
  `select slug, language_choice_count
   from rpg.phb_background
   where slug in ('acolyte','soldier','criminal','sage')
   order by slug`,
);
console.log("phb bg", phb.rows);

const fl = await c.query(
  `select b.slug as bg, l.slug as lang
   from rpg.phb_background_language bl
   join rpg.phb_background b on b.id = bl.background_id
   join rpg.phb_language l on l.id = bl.language_id
   where b.slug in ('acolyte','soldier','gh-free-swords-mercenary')
   order by b.slug, l.slug`,
);
console.log("fixed langs", fl.rows);

const counts = await c.query(
  `select language_choice_count as n, count(*)::int as c
   from rpg.phb_background
   group by language_choice_count
   order by language_choice_count`,
);
console.log("choice distribution", counts.rows);

const ghFixed = await c.query(
  `select count(*)::int as c
   from rpg.phb_background_language bl
   join rpg.phb_background b on b.id = bl.background_id
   where b.slug like 'gh-%'`,
);
console.log("gh backgrounds with fixed langs rows", ghFixed.rows[0]);

await c.end();
