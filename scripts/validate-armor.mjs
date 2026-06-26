/**
 * Valida glossário de armaduras e armor.json estruturado.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const armorDir = path.join(root, "data/phb/armor");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);

function loadSchema(file) {
  ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, file), "utf8")));
}

loadSchema("equipment-entry.schema.json");
loadSchema("class.schema.json");
loadSchema("armor.schema.json");
loadSchema("armor-properties.schema.json");

const validateProperties = ajv.getSchema("https://rpg.local/schema/armor-properties.schema.json");
const validateArmor = ajv.getSchema("https://rpg.local/schema/armor.schema.json");

const propertiesDoc = JSON.parse(
  fs.readFileSync(path.join(armorDir, "properties.json"), "utf8")
);
const armorDoc = JSON.parse(fs.readFileSync(path.join(armorDir, "armor.json"), "utf8"));

const propertyIds = new Set(propertiesDoc.armorProperties.map((p) => p.id));
const formulaTypes = new Set(propertiesDoc.acFormulaTypes.map((f) => f.id));

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

if (!validateProperties(propertiesDoc)) {
  fail(`properties.json — ${ajv.errorsText(validateProperties.errors)}`);
}

if (!validateArmor(armorDoc)) {
  fail(`armor.json — ${ajv.errorsText(validateArmor.errors)}`);
}

for (const item of armorDoc.items) {
  if (!item.acFormula?.type || !formulaTypes.has(item.acFormula.type)) {
    fail(`${item.id}: acFormula.type inválido`);
  }
  if (!Array.isArray(item.propertyIds)) {
    fail(`${item.id}: propertyIds ausente — rode npm run apply:armor`);
    continue;
  }
  for (const id of item.propertyIds) {
    if (!propertyIds.has(id)) fail(`${item.id}: propertyId desconhecido ${id}`);
  }
  if (item.strengthMinimum != null && !item.propertyIds.includes("strength-requirement")) {
    fail(`${item.id}: strengthMinimum sem propertyId strength-requirement`);
  }
  if (item.stealthDisadvantage && !item.propertyIds.includes("stealth-disadvantage")) {
    fail(`${item.id}: stealthDisadvantage sem propertyId stealth-disadvantage`);
  }
  if (item.category === "shield" && !item.propertyIds.includes("shield-ac-bonus")) {
    fail(`${item.id}: escudo sem shield-ac-bonus`);
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log("✓ armor/properties.json");
console.log("✓ armor/armor.json");
console.log(`\n✓ Armaduras válidas (${armorDoc.items.length} itens, ${propertyIds.size} propriedades).`);
process.exit(0);
