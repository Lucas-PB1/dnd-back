/**
 * Valida listas por classe e progressão nas classes conjuradoras.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";
import { SPELL_LIST_CLASSES } from "./spell-class-map.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);
const classSchema = JSON.parse(
  fs.readFileSync(path.join(schemaDir, "class.schema.json"), "utf8")
);
ajv.addSchema(classSchema);

const validateSpellByClass = ajv.compile(
  JSON.parse(fs.readFileSync(path.join(schemaDir, "spell-by-class.schema.json"), "utf8"))
);
const validateIndex = ajv.compile(
  JSON.parse(
    fs.readFileSync(path.join(schemaDir, "spells-by-class-index.schema.json"), "utf8")
  )
);
const validateClass = ajv.getSchema("https://rpg.local/schema/class.schema.json");

let errors = 0;

const byClassDir = path.join(root, "data/phb/spells/by-class");
for (const { id } of SPELL_LIST_CLASSES) {
  const file = path.join(byClassDir, `${id}.json`);
  const doc = JSON.parse(fs.readFileSync(file, "utf8"));
  if (!validateSpellByClass(doc)) {
    console.error(`✗ ${id}.json`, validateSpellByClass.errors);
    errors++;
  }
}

const indexPath = path.join(byClassDir, "index.json");
const indexDoc = JSON.parse(fs.readFileSync(indexPath, "utf8"));
if (!validateIndex(indexDoc)) {
  console.error("✗ by-class/index.json", validateIndex.errors);
  errors++;
}

for (const classId of Object.keys(CLASS_PROGRESSION)) {
  const file = path.join(root, "data/phb/classes", `${classId}.json`);
  const doc = JSON.parse(fs.readFileSync(file, "utf8"));
  if (!validateClass(doc)) {
    console.error(`✗ classes/${classId}.json`, validateClass.errors);
    errors++;
  }
}

if (errors) {
  console.error(`\n${errors} arquivo(s) com erro de schema.`);
  process.exit(1);
}

console.log("✓ Validação OK — 8 listas + índice + 8 classes com progression");
process.exit(0);
