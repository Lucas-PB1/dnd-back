/**
 * DEV: dev-reset + migrations + seeds.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { spawnSync } from "child_process";
import { applySeeds } from "./run-seeds.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const devReset = path.join(root, "database/dev-reset.sql");
if (!fs.existsSync(devReset)) {
  console.error("✗ database/dev-reset.sql ausente — rode npm run generate:sql-schema");
  process.exit(1);
}

let pg;
try {
  pg = await import("pg");
} catch {
  console.error("✗ Instale pg: npm install pg");
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

const client = new pg.default.Client({ connectionString: url });
try {
  await client.connect();
  console.log("→ dev-reset.sql");
  await client.query(fs.readFileSync(devReset, "utf8"));
} finally {
  await client.end();
}

const migrate = spawnSync(process.execPath, [path.join(__dirname, "run-migrations.mjs")], {
  cwd: root,
  stdio: "inherit",
  env: process.env,
});
if (migrate.status !== 0) process.exit(migrate.status ?? 1);

const seedClient = new pg.default.Client({ connectionString: url });
try {
  await seedClient.connect();
  await applySeeds(seedClient);
} catch (err) {
  console.error(`✗ ${err.message}`);
  process.exit(1);
} finally {
  await seedClient.end();
}

console.log("✓ Bootstrap DEV concluído");
