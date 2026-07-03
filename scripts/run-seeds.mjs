/**
 * Aplica seeds em database/seeds/ (ordem lexicográfica, recursiva, uma transação).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { refreshMaterializedViews } from "./lib/refresh-views.mjs";
import { collectSeedFiles } from "./lib/seed-writer.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const seedsDir = path.join(root, "database", "seeds");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

export async function applySeeds(client) {
  if (!fs.existsSync(seedsDir)) {
    throw new Error("database/seeds/ ausente — rode npm run generate:seed");
  }
  const files = collectSeedFiles(seedsDir);
  if (!files.length) {
    throw new Error("Nenhum seed em database/seeds/");
  }

  await client.query("BEGIN");
  try {
    for (const file of files) {
      const sql = fs.readFileSync(file, "utf8");
      const rel = path.relative(seedsDir, file).replace(/\\/g, "/");
      console.log(`→ seeds/${rel}`);
      await client.query(sql);
    }
    await client.query("COMMIT");
  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  }
  return files.length;
}

async function main() {
  let pg;
  try {
    pg = await import("pg");
  } catch {
    console.error("✗ Instale pg: npm install pg");
    process.exit(1);
  }

  const client = new pg.default.Client({ connectionString: url });
  try {
    await client.connect();
    const n = await applySeeds(client);
    const counts = await client.query(`
      SELECT
        (SELECT COUNT(*)::int FROM rpg.phb_spell) AS spells,
        (SELECT COUNT(*)::int FROM rpg.phb_class) AS classes,
        (SELECT COUNT(*)::int FROM rpg.phb_item) AS items
    `);
    console.log(
      `✓ ${n} seed(s) — ${counts.rows[0].spells} magias, ${counts.rows[0].classes} classes, ${counts.rows[0].items} itens`
    );
    if (await refreshMaterializedViews(client)) {
      const mv = await client.query("SELECT COUNT(*)::int AS n FROM rpg.mv_spell_by_class");
      console.log(`✓ mv_spell_by_class — ${mv.rows[0].n} linhas`);
    }
  } catch (err) {
    console.error(`✗ ${err.message}`);
    process.exit(1);
  } finally {
    await client.end();
  }
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  main();
}
