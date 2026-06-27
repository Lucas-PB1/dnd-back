/**
 * Aplica seed no PostgreSQL via DATABASE_URL ou PGPASSWORD + defaults locais.
 * Requer: npm install pg
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { spawnSync } from "child_process";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const psqlCandidates = [
  process.env.PSQL_PATH,
  "C:\\Program Files\\PostgreSQL\\17\\bin\\psql.exe",
  "C:\\Program Files\\PostgreSQL\\16\\bin\\psql.exe",
].filter(Boolean);

async function runWithPg() {
  let pg;
  try {
    pg = await import("pg");
  } catch {
    return false;
  }

  const seedFile = path.join(root, "database/seed-all.sql");
  if (!fs.existsSync(seedFile)) {
    console.error("✗ database/seed-all.sql ausente — rode npm run generate:seed");
    process.exit(1);
  }

  const adminUrl = url.replace(/\/rpg(\?|$)/, "/postgres$1");
  const admin = new pg.default.Client({ connectionString: adminUrl });
  await admin.connect();
  const { rows } = await admin.query("SELECT 1 FROM pg_database WHERE datname = 'rpg'");
  if (!rows.length) {
    await admin.query("CREATE DATABASE rpg");
    console.log("✓ Banco rpg criado");
  }
  await admin.end();

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
      `✓ Seed aplicado — ${counts.rows[0].spells} magias, ${counts.rows[0].classes} classes, ${counts.rows[0].items} itens`
    );
    return true;
  } finally {
    await client.end();
  }
}

function runWithPsql() {
  const psql = psqlCandidates.find((p) => fs.existsSync(p));
  if (!psql) return false;

  const seedFile = path.join(root, "database/seed-all.sql");
  const env = { ...process.env, PGPASSWORD: process.env.PGPASSWORD ?? "postgres" };

  spawnSync(psql, ["-U", "postgres", "-h", "localhost", "-d", "postgres", "-c", "CREATE DATABASE rpg"], {
    env,
    stdio: "ignore",
  });

  const r = spawnSync(
    psql,
    ["-U", "postgres", "-h", "localhost", "-d", "rpg", "-v", "ON_ERROR_STOP=1", "-f", seedFile],
    { env, encoding: "utf8" }
  );

  if (r.status !== 0) {
    console.error(r.stderr || r.stdout);
    process.exit(1);
  }

  const check = spawnSync(
    psql,
    [
      "-U",
      "postgres",
      "-h",
      "localhost",
      "-d",
      "rpg",
      "-t",
      "-c",
      "SELECT (SELECT COUNT(*) FROM rpg.phb_spell) || ' magias, ' || (SELECT COUNT(*) FROM rpg.phb_class) || ' classes'",
    ],
    { env, encoding: "utf8" }
  );
  console.log(`✓ Seed aplicado — ${check.stdout.trim()}`);
  return true;
}

try {
  if (process.env.SEED_USE_PSQL === "1" && runWithPsql()) {
    process.exit(0);
  }
  if (await runWithPg()) {
    process.exit(0);
  }
  if (runWithPsql()) {
    process.exit(0);
  }
  console.error("✗ Não foi possível conectar. Defina DATABASE_URL ou instale PostgreSQL/psql.");
  process.exit(1);
} catch (err) {
  console.error(`✗ ${err.message}`);
  process.exit(1);
}
