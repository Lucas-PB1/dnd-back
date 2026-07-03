/**
 * Gera arquivos em database/seeds/ a partir do PHB JSON.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { spawnSync } from "child_process";
import { collectSeedFiles, prepareSeedsDir, removeEmptyDirs } from "./lib/seed-writer.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const seedsDir = path.join(root, "database", "seeds");
const migrationsDir = path.join(root, "database", "migrations");

function run(script) {
  const r = spawnSync(process.execPath, [path.join(__dirname, script)], {
    cwd: root,
    stdio: "inherit",
  });
  if (r.status !== 0) process.exit(r.status ?? 1);
}

prepareSeedsDir(seedsDir);
run("seed-phb.mjs");
run("generate-seed-subclass-mechanics.mjs");

removeEmptyDirs(path.join(root, "database"));
removeEmptyDirs(migrationsDir);

const files = collectSeedFiles(seedsDir);
console.log(`✓ ${files.length} seed(s) em database/seeds/`);
for (const f of files.map((p) => path.relative(seedsDir, p))) console.log(`  ${f}`);
