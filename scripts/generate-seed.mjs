/**
 * Gera arquivos em database/seeds/ a partir do PHB JSON.
 * Produção: npm run migrate:run && npm run seed:prod
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { spawnSync } from "child_process";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const seedsDir = path.join(root, "database", "seeds");

function run(script) {
  const r = spawnSync(process.execPath, [path.join(__dirname, script)], {
    cwd: root,
    stdio: "inherit",
  });
  if (r.status !== 0) process.exit(r.status ?? 1);
}

fs.mkdirSync(seedsDir, { recursive: true });
run("seed-phb.mjs");
run("generate-seed-subclass-mechanics.mjs");

const files = fs
  .readdirSync(seedsDir)
  .filter((f) => f.endsWith(".sql"))
  .sort();

console.log(`✓ ${files.length} seed(s) em database/seeds/`);
for (const f of files) console.log(`  ${f}`);
