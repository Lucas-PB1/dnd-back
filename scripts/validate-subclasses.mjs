/**
 * Valida subclasses: schema, ids de magia e coerência das tabelas preparadas.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const subclassesDir = path.join(root, "data/phb/subclasses");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "equipment-entry.schema.json"), "utf8")));
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "class.schema.json"), "utf8")));
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "subclass.schema.json"), "utf8")));
const validateSubclass = ajv.getSchema("https://rpg.local/schema/subclass.schema.json");

const spellIds = new Set(
  JSON.parse(fs.readFileSync(path.join(root, "data/phb/spells/index.json"), "utf8")).spells.map(
    (s) => s.id
  )
);

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

function collectSpellsFromTable(table, label) {
  if (!table) return;
  for (const [lvl, ids] of Object.entries(table)) {
    if (!/^[0-9]+$/.test(lvl)) fail(`${label}: nível inválido "${lvl}"`);
    if (!Array.isArray(ids) || ids.length === 0) {
      fail(`${label}: nível ${lvl} sem magias`);
      continue;
    }
    const unique = new Set(ids);
    if (unique.size !== ids.length) fail(`${label}: magias duplicadas no nível ${lvl}`);
    for (const id of ids) {
      if (!spellIds.has(id)) fail(`${label}: spellId desconhecido ${id}`);
    }
  }
}

const files = fs.readdirSync(subclassesDir).filter((f) => f.endsWith(".json"));
let withSpells = 0;

for (const file of files) {
  const doc = JSON.parse(fs.readFileSync(path.join(subclassesDir, file), "utf8"));
  const label = file.replace(".json", "");

  if (!validateSubclass(doc)) {
    fail(`${label}: schema — ${ajv.errorsText(validateSubclass.errors)}`);
    continue;
  }

  const hasLevelTable = doc.preparedSpellsByLevel != null;
  const hasTerrainTable = doc.preparedSpellsByTerrain != null;

  if (hasLevelTable || hasTerrainTable) {
    withSpells++;
    if (!doc.preparedSpellSourceKey) {
      fail(`${label}: preparedSpellSourceKey ausente`);
    }
  }

  if (hasLevelTable) collectSpellsFromTable(doc.preparedSpellsByLevel, label);

  if (hasTerrainTable) {
    if (!Array.isArray(doc.landTerrainIds) || doc.landTerrainIds.length === 0) {
      fail(`${label}: landTerrainIds ausente com preparedSpellsByTerrain`);
    }
    for (const terrainId of doc.landTerrainIds ?? []) {
      collectSpellsFromTable(doc.preparedSpellsByTerrain?.[terrainId], `${label}/${terrainId}`);
    }
    for (const terrainId of Object.keys(doc.preparedSpellsByTerrain ?? {})) {
      if (!doc.landTerrainIds?.includes(terrainId)) {
        fail(`${label}: terreno "${terrainId}" não listado em landTerrainIds`);
      }
    }
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(`✓ ${files.length} subclasse(s) — ${withSpells} com magias preparadas`);
process.exit(0);
