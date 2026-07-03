/**
 * Valida arquivos de seed gerados (catálogo PHB).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { loadPhbCatalog } from "./lib/phb-loader.mjs";
import { collectSeedFiles } from "./lib/seed-writer.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const seedsDir = path.join(root, "database", "seeds");
const manifestFile = path.join(root, "database", "seed-manifest.json");

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

const truncateFile = path.join(seedsDir, "000_truncate.sql");
if (!fs.existsSync(truncateFile)) {
  fail("database/seeds/000_truncate.sql ausente — rode npm run generate:seed");
}

const seedFiles = collectSeedFiles(seedsDir);
const phbSeeds = seedFiles.filter((f) => f.includes(`${path.sep}phb${path.sep}`));
if (phbSeeds.length < 10) {
  fail(`esperado seeds por tabela em database/seeds/phb/ (encontrados ${phbSeeds.length})`);
}

if (errors) process.exit(1);

const catalog = loadPhbCatalog(root);
const manifest = JSON.parse(fs.readFileSync(manifestFile, "utf8"));
const phbSql = phbSeeds.map((f) => fs.readFileSync(f, "utf8")).join("\n");

const expectations = {
  "rpg.phb_spell": catalog.counts.spells,
  "rpg.phb_class": catalog.counts.classes,
  "rpg.phb_species": catalog.counts.species,
  "rpg.phb_background": catalog.counts.backgrounds,
  "rpg.phb_feat": catalog.counts.feats,
};

for (const [table, expected] of Object.entries(expectations)) {
  const re = new RegExp(`INSERT INTO ${table.replace(".", "\\.")}`, "g");
  const found = (phbSql.match(re) ?? []).length;
  if (found < 1) {
    fail(`nenhum INSERT em ${table} (esperado ~${expected})`);
  }
}

if (/player_character/i.test(phbSql)) {
  fail("seed PHB não deve referenciar player_character");
}

if (manifest.phb?.spells !== catalog.counts.spells) {
  fail(`manifest spells ${manifest.phb?.spells} ≠ catálogo ${catalog.counts.spells}`);
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(
  `✓ Seeds válidos — ${phbSeeds.length} tabelas PHB + subclass (${catalog.counts.spells} magias)`
);
process.exit(0);
