/**
 * Produção/staging: migrations pendentes + seeds (sem DROP SCHEMA).
 */
import { spawnSync } from "child_process";
import path from "path";
import { fileURLToPath } from "url";
import { applySeeds } from "./run-seeds.mjs";

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
  await applySeeds(client);
  console.log("✓ Catálogo PHB aplicado (prod/staging)");
} catch (err) {
  console.error(`✗ ${err.message}`);
  process.exit(1);
} finally {
  await client.end();
}
