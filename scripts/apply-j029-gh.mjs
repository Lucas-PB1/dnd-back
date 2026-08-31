/**
 * Reaplica J029: limpa prepared_spell das subclasses GH Cap.2 e reinsere o seed.
 * Uso: node scripts/apply-j029-gh.mjs [--target=local|supabase]
 */
import fs from "fs";
import path from "path";
import { loadEnv, rootDir } from "./lib/load-env.mjs";
import { createPgClient, maskDatabaseUrl } from "./lib/pg-client.mjs";

loadEnv();

const targetArg = process.argv.find((a) => a.startsWith("--target="));
const target = targetArg?.split("=")[1] ?? "local";
const url =
  target === "supabase"
    ? process.env.SUPABASE_DATABASE_URL
    : process.env.DATABASE_URL;
if (!url) {
  console.error(`URL não definida para target=${target}`);
  process.exit(1);
}

const seedPath = path.join(
  rootDir,
  "database/seeds/grim-hollow/J029_phb_subclass_prepared_spell.sql",
);
const sql = fs.readFileSync(seedPath, "utf8");
const slugs = [
  ...new Set([...sql.matchAll(/^-- ([a-z0-9-]+) L\d+/gm)].map((m) => m[1])),
];

const client = createPgClient(url);
await client.connect();
console.log(`J029 → ${maskDatabaseUrl(url)}`);

const { rows: before } = await client.query(
  `SELECT COUNT(*)::int AS n
   FROM rpg.phb_subclass_prepared_spell psp
   JOIN rpg.phb_subclass sc ON sc.id = psp.subclass_id
   WHERE sc.slug = ANY($1)`,
  [slugs],
);
console.log(`before: ${before[0].n} rows`);

await client.query("BEGIN");
try {
  const del = await client.query(
    `DELETE FROM rpg.phb_subclass_prepared_spell psp
     USING rpg.phb_subclass sc
     WHERE psp.subclass_id = sc.id AND sc.slug = ANY($1)`,
    [slugs],
  );
  console.log(`deleted ${del.rowCount} old rows (${slugs.length} subclasses)`);
  await client.query(sql);
  await client.query("COMMIT");
} catch (e) {
  await client.query("ROLLBACK");
  throw e;
}

const { rows: after } = await client.query(
  `SELECT sc.slug, COUNT(*)::int AS n
   FROM rpg.phb_subclass_prepared_spell psp
   JOIN rpg.phb_subclass sc ON sc.id = psp.subclass_id
   WHERE sc.slug = ANY($1)
   GROUP BY sc.slug
   ORDER BY sc.slug`,
  [slugs],
);
const total = after.reduce((a, r) => a + r.n, 0);
console.log(`after: ${total} rows across ${after.length} subclasses`);
for (const r of after) console.log(`  ${r.slug}: ${r.n}`);

const curated = [
  "occultist-guild",
  "collegeof-fools",
  "collegeof-requiems",
  "pathofthe-primal-spirit",
  "pathofthe-wrathful-dead",
  "highway-rider",
  "wretched-bloodline-sorcery",
  "the-parasite-patron",
  "warriorofthe-leaden-crown",
];
const missingCurated = curated.filter((s) => !after.some((r) => r.slug === s));
if (missingCurated.length) {
  console.log("MISSING curated grants:", missingCurated.join(", "));
} else {
  console.log("curated gaps: all present");
}

await client.end();
