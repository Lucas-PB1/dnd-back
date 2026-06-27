/**
 * Valida arquivos de seed gerados (contagens + integridade JSON).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { loadPhbCatalog, loadCharacters } from "./lib/phb-loader.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const manifestFile = path.join(root, "database/seed-manifest.json");

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

const required = [
  "database/seed-phb.sql",
  "database/seed-characters.sql",
  "database/seed-all.sql",
];

for (const rel of required) {
  if (!fs.existsSync(path.join(root, rel))) {
    fail(`${rel} ausente — rode npm run generate:seed`);
  }
}

if (errors) process.exit(1);

const catalog = loadPhbCatalog(root);
const characters = loadCharacters(root);
const manifest = JSON.parse(fs.readFileSync(manifestFile, "utf8"));
const phbSql = fs.readFileSync(path.join(root, "database/seed-phb.sql"), "utf8");
const charSql = fs.readFileSync(path.join(root, "database/seed-characters.sql"), "utf8");

const expectations = {
  "rpg.phb_spell": catalog.counts.spells,
  "rpg.phb_class": catalog.counts.classes,
  "rpg.phb_species": catalog.counts.species,
  "rpg.phb_background": catalog.counts.backgrounds,
  "rpg.phb_feat": catalog.counts.feats,
  "rpg.player_character": characters.length,
};

for (const [table, expected] of Object.entries(expectations)) {
  const re = new RegExp(`INSERT INTO ${table.replace(".", "\\.")}`, "g");
  const found = (phbSql.match(re) ?? []).length + (charSql.match(re) ?? []).length;
  if (found < 1) {
    fail(`nenhum INSERT em ${table} (esperado ~${expected})`);
  }
}

if (manifest.phb?.spells !== catalog.counts.spells) {
  fail(`manifest spells ${manifest.phb?.spells} ≠ catálogo ${catalog.counts.spells}`);
}
if (manifest.characters?.count !== characters.length) {
  fail(`manifest characters ${manifest.characters?.count} ≠ ${characters.length}`);
}

// FK refs nas fichas
const spellIds = new Set(catalog.spells.map((s) => s.id));
const itemWeaponIds = new Set(catalog.items.filter((i) => i.weapon).map((i) => i.id));

for (const doc of characters) {
  for (const wm of doc.weaponMasteryWeaponIds ?? []) {
    if (!itemWeaponIds.has(wm)) {
      fail(`${doc.id}: weapon mastery ${wm} não é arma no catálogo`);
    }
  }
  if (doc.spellcasting) {
    for (const listType of ["cantrips", "prepared"]) {
      for (const ids of Object.values(doc.spellcasting[listType] ?? {})) {
        for (const sid of ids) {
          if (!spellIds.has(sid)) fail(`${doc.id}: spell ${sid} ausente no catálogo`);
        }
      }
    }
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(`✓ Seed válido — PHB (${catalog.counts.spells} magias) + ${characters.length} personagens`);
process.exit(0);
