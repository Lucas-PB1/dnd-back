/**
 * Aplica database/seed-subclass-mechanics.sql no PostgreSQL.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const seedFile = path.join(root, "database", "seed-subclass-mechanics.sql");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

if (!fs.existsSync(seedFile)) {
  console.error("✗ seed-subclass-mechanics.sql ausente — rode npm run generate:seed-subclass-mechanics");
  process.exit(1);
}

const pg = await import("pg");
const client = new pg.default.Client({ connectionString: url });
await client.connect();
try {
  const sql = fs.readFileSync(seedFile, "utf8");
  await client.query(sql);
  console.log("✓ Mecânicas de subclasse aplicadas");
} finally {
  await client.end();
}
