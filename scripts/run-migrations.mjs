/**
 * Aplica migrations pendentes em database/migrations/ (ordem lexicográfica, recursiva).
 * Registra versões em rpg.schema_migration (caminho relativo sem .sql).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const migrationsDir = path.join(root, "database", "migrations");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

function collectSqlFiles(dir) {
  /** @type {string[]} */
  const files = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, entry.name);
    if (entry.isDirectory()) files.push(...collectSqlFiles(p));
    else if (entry.name.endsWith(".sql")) files.push(p);
  }
  return files.sort((a, b) => a.localeCompare(b));
}

async function main() {
  let pg;
  try {
    pg = await import("pg");
  } catch {
    console.error("✗ Instale pg: npm install pg");
    process.exit(1);
  }

  if (!fs.existsSync(migrationsDir)) {
    console.error("✗ database/migrations/ ausente — rode npm run generate:sql-schema");
    process.exit(1);
  }

  const files = collectSqlFiles(migrationsDir);
  if (!files.length) {
    console.error("✗ Nenhuma migration em database/migrations/");
    process.exit(1);
  }

  const adminUrl = url.replace(/\/rpg(\?|$)/, "/postgres$1");
  const admin = new pg.default.Client({ connectionString: adminUrl });
  await admin.connect();
  const { rows: dbs } = await admin.query("SELECT 1 FROM pg_database WHERE datname = 'rpg'");
  if (!dbs.length) {
    await admin.query("CREATE DATABASE rpg");
    console.log("✓ Banco rpg criado");
  }
  await admin.end();

  const client = new pg.default.Client({ connectionString: url });
  await client.connect();

  try {
    await client.query("CREATE SCHEMA IF NOT EXISTS rpg");
    await client.query(`
      CREATE TABLE IF NOT EXISTS rpg.schema_migration (
        version    TEXT PRIMARY KEY,
        applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      )
    `);

    const { rows: applied } = await client.query(
      "SELECT version FROM rpg.schema_migration ORDER BY version"
    );
    const done = new Set(applied.map((r) => r.version));

    let count = 0;
    for (const file of files) {
      const version = path
        .relative(migrationsDir, file)
        .replace(/\\/g, "/")
        .replace(/\.sql$/, "");
      if (done.has(version)) continue;

      const sql = fs.readFileSync(file, "utf8");
      console.log(`→ ${version}`);
      await client.query("BEGIN");
      try {
        await client.query(sql);
        await client.query(
          "INSERT INTO rpg.schema_migration (version) VALUES ($1)",
          [version]
        );
        await client.query("COMMIT");
        count++;
      } catch (err) {
        await client.query("ROLLBACK");
        throw err;
      }
    }

    if (count === 0) {
      console.log(`✓ Migrations em dia (${files.length} arquivo(s))`);
    } else {
      console.log(`✓ ${count} migration(s) aplicada(s)`);
    }
  } finally {
    await client.end();
  }
}

main().catch((err) => {
  console.error(`✗ ${err.message}`);
  process.exit(1);
});
