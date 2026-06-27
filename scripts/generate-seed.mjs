/**
 * Gera database/seed-all.sql (schema + PHB + personagens).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { spawnSync } from "child_process";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

function run(script) {
  const r = spawnSync(process.execPath, [path.join(__dirname, script)], {
    cwd: root,
    stdio: "inherit",
  });
  if (r.status !== 0) process.exit(r.status ?? 1);
}

run("seed-phb.mjs");
run("import-characters.mjs");

const schema = fs.readFileSync(path.join(root, "database/schema.sql"), "utf8");
const phb = fs.readFileSync(path.join(root, "database/seed-phb.sql"), "utf8");
const chars = fs.readFileSync(path.join(root, "database/seed-characters.sql"), "utf8");

const all = `-- RPG — bootstrap completo (schema + seed)
-- Gerado por: npm run generate:seed
-- Uso: psql -U postgres -d rpg -f database/seed-all.sql

${schema}

${phb}

${chars}
`;

const out = path.join(root, "database/seed-all.sql");
fs.writeFileSync(out, all, "utf8");
console.log(`✓ ${path.relative(root, out)} (${all.split("\n").length} linhas)`);
