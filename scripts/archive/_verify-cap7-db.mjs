import { readFileSync } from "node:fs";
import { loadEnv } from "../lib/load-env.mjs";
import { createPgClient } from "../lib/pg-client.mjs";
import { extracts } from "../lib/docs-source.mjs";

loadEnv();

const extract = JSON.parse(
  readFileSync(extracts.grimHollow.cap7Spells, "utf8"),
);
const spells = extract.spells ?? extract;
const list = Array.isArray(spells) ? spells : Object.values(spells);

const client = createPgClient(process.env.DATABASE_URL);
await client.connect();

const slugs = list.map((s) => s.slug).filter(Boolean);
const { rows: colRows } = await client.query(
  `SELECT column_name FROM information_schema.columns
   WHERE table_schema = 'rpg' AND table_name = 'phb_spell'
   ORDER BY ordinal_position`,
);
const cols = colRows.map((r) => r.column_name);
const pick = ["slug", "name", "level", "school", "casting_time", "range_text", "range"].filter(
  (c) => cols.includes(c),
);
const { rows } = await client.query(
  `SELECT ${pick.join(", ")} FROM rpg.phb_spell WHERE slug = ANY($1)`,
  [slugs],
);
const bySlug = new Map(rows.map((r) => [r.slug, r]));

const missing = [];
const mismatches = [];
for (const s of list) {
  const db = bySlug.get(s.slug);
  if (!db) {
    missing.push(s.slug);
    continue;
  }
  if (s.name && db.name !== s.name) {
    mismatches.push({ slug: s.slug, json: s.name, db: db.name });
  }
}

const { rows: classLinks } = await client.query(
  `SELECT COUNT(*)::int AS n FROM rpg.phb_spell_class sc
   JOIN rpg.phb_spell sp ON sp.id = sc.spell_id
   WHERE sp.slug = ANY($1)`,
  [slugs],
);

const { rows: orphan } = await client.query(
  `SELECT slug FROM rpg.phb_spell WHERE slug = 'shadowsteel-focus'`,
);

console.log(
  JSON.stringify(
    {
      extractCount: list.length,
      inDb: rows.length,
      missingInDb: missing,
      nameMismatches: mismatches.slice(0, 10),
      nameMismatchCount: mismatches.length,
      spellClassLinks: classLinks[0]?.n,
      orphanShadowsteelFocus: orphan.length > 0,
      sample: rows.slice(0, 3),
    },
    null,
    2,
  ),
);

await client.end();
