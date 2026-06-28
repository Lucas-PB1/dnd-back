/**
 * Gera database/seed-all.sql (dev-reset + schema + PHB).
 * Produção: npm run migrate:run && npm run seed:prod
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

const devReset = fs.readFileSync(path.join(root, "database/dev-reset.sql"), "utf8");
const schema = fs.readFileSync(path.join(root, "database/schema.sql"), "utf8");
const phb = fs.readFileSync(path.join(root, "database/seed-phb.sql"), "utf8");

const all = `-- RPG — bootstrap DEV ONLY (dev-reset + schema + seed PHB)
-- Gerado por: npm run generate:seed
-- NUNCA rodar em produção — use npm run seed:prod
-- Uso local: npm run seed:run

${devReset}

${schema}

${phb}
`;

const out = path.join(root, "database/seed-all.sql");
fs.writeFileSync(out, all, "utf8");
console.log(`✓ ${path.relative(root, out)} (${all.split("\n").length} linhas)`);
