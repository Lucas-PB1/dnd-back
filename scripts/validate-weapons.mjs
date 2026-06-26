/**
 * Valida glossário de armas, weapons.json e mastery-progression.json.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const weaponsDir = path.join(root, "data/phb/weapons");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);

function loadSchema(file) {
  ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, file), "utf8")));
}

loadSchema("equipment-entry.schema.json");
loadSchema("class.schema.json");
loadSchema("weapon.schema.json");
loadSchema("weapon-properties.schema.json");
loadSchema("weapon-mastery-progression.schema.json");

const validateProperties = ajv.getSchema("https://rpg.local/schema/weapon-properties.schema.json");
const validateWeapons = ajv.getSchema("https://rpg.local/schema/weapon.schema.json");
const validateMastery = ajv.getSchema(
  "https://rpg.local/schema/weapon-mastery-progression.schema.json"
);

const propertiesDoc = JSON.parse(
  fs.readFileSync(path.join(weaponsDir, "properties.json"), "utf8")
);
const weaponsDoc = JSON.parse(fs.readFileSync(path.join(weaponsDir, "weapons.json"), "utf8"));
const masteryDoc = JSON.parse(
  fs.readFileSync(path.join(weaponsDir, "mastery-progression.json"), "utf8")
);

const propertyIds = new Set(propertiesDoc.weaponProperties.map((p) => p.id));
const masteryIds = new Set(propertiesDoc.weaponMasteries.map((m) => m.id));

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

if (!validateProperties(propertiesDoc)) {
  fail(`properties.json — ${ajv.errorsText(validateProperties.errors)}`);
}

if (!validateWeapons(weaponsDoc)) {
  fail(`weapons.json — ${ajv.errorsText(validateWeapons.errors)}`);
}

if (!validateMastery(masteryDoc)) {
  fail(`mastery-progression.json — ${ajv.errorsText(validateMastery.errors)}`);
}

for (const weapon of weaponsDoc.weapons) {
  if (!Array.isArray(weapon.propertyIds)) {
    fail(`${weapon.id}: propertyIds ausente — rode npm run apply:weapons`);
    continue;
  }
  for (const id of weapon.propertyIds) {
    if (!propertyIds.has(id)) fail(`${weapon.id}: propertyId desconhecido ${id}`);
  }
  if (!weapon.masteryId || !masteryIds.has(weapon.masteryId)) {
    fail(`${weapon.id}: masteryId inválido ${weapon.masteryId}`);
  }
  if (weapon.mastery) {
    const expected = propertiesDoc.weaponMasteries.find((m) => m.id === weapon.masteryId)?.name;
    if (expected && weapon.mastery !== expected) {
      fail(`${weapon.id}: mastery "${weapon.mastery}" ≠ glossário "${expected}"`);
    }
  }
  const hasFinesseId = weapon.propertyIds.includes("finesse");
  const hasFinesseLegacy = weapon.properties?.includes("Acuidade");
  if (hasFinesseId !== Boolean(hasFinesseLegacy)) {
    fail(
      `${weapon.id}: Acuidade inconsistente (propertyIds finesse=${hasFinesseId}, texto=${hasFinesseLegacy})`
    );
  }
}

for (const [classId, rule] of Object.entries(masteryDoc.classes)) {
  const thresholds = Object.keys(rule.slotsByLevel)
    .map(Number)
    .sort((a, b) => a - b);
  let last = 0;
  for (const lvl of thresholds) {
    const slots = rule.slotsByLevel[String(lvl)];
    if (slots < last) fail(`${classId}: slotsByLevel não crescente no nível ${lvl}`);
    last = slots;
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log("✓ weapons/properties.json");
console.log("✓ weapons/weapons.json");
console.log("✓ weapons/mastery-progression.json");
console.log(`\n✓ Armas válidas (${weaponsDoc.weapons.length} itens, ${propertyIds.size} propriedades, ${masteryIds.size} maestrias).`);
process.exit(0);
