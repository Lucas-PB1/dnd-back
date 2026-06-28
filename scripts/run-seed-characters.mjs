/**
 * Aplica seed de fichas (requer catálogo PHB + migration 003).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const seedFile = path.join(root, "database/seed-characters.sql");
if (!fs.existsSync(seedFile)) {
  console.error("✗ database/seed-characters.sql ausente — rode npm run generate:seed-characters");
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
  const { rows } = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.player_character
  `);
  console.log(`✓ Fichas importadas — ${rows[0].n} personagens`);
} catch (err) {
  console.error(`✗ ${err.message}`);
  process.exit(1);
} finally {
  await client.end();
}
