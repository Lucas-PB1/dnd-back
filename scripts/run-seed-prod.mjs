/**
 * Deploy catálogo em produção/staging: migrations + seed PHB (sem DROP SCHEMA).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { spawnSync } from "child_process";
import { refreshMaterializedViews } from "./lib/refresh-views.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const migrate = spawnSync(process.execPath, [path.join(__dirname, "run-migrations.mjs")], {
  cwd: root,
  stdio: "inherit",
  env: process.env,
});
if (migrate.status !== 0) process.exit(migrate.status ?? 1);

const seedFile = path.join(root, "database/seed-phb.sql");
if (!fs.existsSync(seedFile)) {
  console.error("✗ database/seed-phb.sql ausente — rode npm run generate:seed-phb");
  process.exit(1);
}

let pg;
try {
  pg = await import("pg");
} catch {
  console.error("✗ Instale pg: npm install pg");
  process.exit(1);
}

const sql = fs.readFileSync(seedFile, "utf8");
const client = new pg.default.Client({ connectionString: url });
try {
  await client.connect();
  await client.query(sql);
  const counts = await client.query(`
    SELECT
      (SELECT COUNT(*)::int FROM rpg.phb_spell) AS spells,
      (SELECT COUNT(*)::int FROM rpg.phb_class) AS classes,
      (SELECT COUNT(*)::int FROM rpg.phb_item) AS items
  `);
  console.log(
    `✓ Catálogo PHB — ${counts.rows[0].spells} magias, ${counts.rows[0].classes} classes, ${counts.rows[0].items} itens`
  );
  if (await refreshMaterializedViews(client)) {
    const mv = await client.query("SELECT COUNT(*)::int AS n FROM rpg.mv_spell_by_class");
    console.log(`✓ mv_spell_by_class — ${mv.rows[0].n} linhas`);
  }
} finally {
  await client.end();
}
