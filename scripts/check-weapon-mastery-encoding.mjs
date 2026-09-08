import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Client } = require("../node_modules/pg");

const c = new Client({
  connectionString: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});
await c.connect();

const rows = await c.query(
  `select w.slug, w.name, m.slug as mastery_slug, m.name as mastery_name
   from rpg.phb_weapon w
   left join rpg.phb_weapon_mastery m on m.id = w.mastery_id
   where w.slug ilike '%psiqu%' or w.slug ilike '%psychic%'
      or w.name ilike '%psiqu%' or w.name ilike '%funda%'
      or m.name ilike '%Ã%'
   order by w.name
   limit 30`,
);
console.log(JSON.stringify(rows.rows, null, 2));

const mojibake = await c.query(
  `select slug, name from rpg.phb_weapon_mastery where name ~ 'Ã' or description ~ 'Ã'`,
);
console.log("mastery mojibake", mojibake.rows);

const weaponMojibake = await c.query(
  `select slug, name from rpg.phb_weapon where name ~ 'Ã' limit 20`,
);
console.log("weapon mojibake", weaponMojibake.rows);

await c.end();
