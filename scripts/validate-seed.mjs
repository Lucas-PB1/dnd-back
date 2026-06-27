/**
 * Valida arquivos de seed gerados (catálogo PHB).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { loadPhbCatalog } from "./lib/phb-loader.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const manifestFile = path.join(root, "database/seed-manifest.json");

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

const required = ["database/seed-phb.sql", "database/seed-all.sql"];

for (const rel of required) {
  if (!fs.existsSync(path.join(root, rel))) {
    fail(`${rel} ausente — rode npm run generate:seed`);
  }
}

if (errors) process.exit(1);

const catalog = loadPhbCatalog(root);
const manifest = JSON.parse(fs.readFileSync(manifestFile, "utf8"));
const phbSql = fs.readFileSync(path.join(root, "database/seed-phb.sql"), "utf8");

const expectations = {
  "rpg.phb_spell": catalog.counts.spells,
  "rpg.phb_class": catalog.counts.classes,
  "rpg.phb_species": catalog.counts.species,
  "rpg.phb_background": catalog.counts.backgrounds,
  "rpg.phb_feat": catalog.counts.feats,
  "rpg.phb_ability": catalog.counts.abilities,
  "rpg.phb_armor_category": catalog.counts.armorCategories,
};

for (const [table, expected] of Object.entries(expectations)) {
  const re = new RegExp(`INSERT INTO ${table.replace(".", "\\.")}`, "g");
  const found = (phbSql.match(re) ?? []).length;
  if (found < 1) {
    fail(`nenhum INSERT em ${table} (esperado ~${expected})`);
  }
}

if (!/INSERT INTO rpg\.phb_spell \(slug,/m.test(phbSql)) {
  fail("seed PHB deve inserir por coluna slug (v4)");
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

console.log(`✓ Seed válido — PHB (${catalog.counts.spells} magias, sem personagens)`);
process.exit(0);
