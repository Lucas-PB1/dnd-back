/**
 * Valida dados de criação de personagem (Cap. 2) em data/phb/creation/.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const creationDir = path.join(root, "data/phb/creation");
const phb = path.join(root, "data/phb");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);
ajv.addSchema(
  JSON.parse(fs.readFileSync(path.join(schemaDir, "equipment-entry.schema.json"), "utf8"))
);
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "class.schema.json"), "utf8")));

const files = [
  ["creation-index.schema.json", "index.json"],
  ["ability-generation.schema.json", "ability-generation.json"],
  ["alignments.schema.json", "alignments.json"],
  ["languages.schema.json", "languages.json"],
];

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

for (const [schemaName, fileName] of files) {
  const validate = ajv.compile(JSON.parse(fs.readFileSync(path.join(schemaDir, schemaName), "utf8")));
  const doc = JSON.parse(fs.readFileSync(path.join(creationDir, fileName), "utf8"));
  if (!validate(doc)) {
    fail(`${fileName}: ${ajv.errorsText(validate.errors)}`);
  } else {
    console.log(`✓ creation/${fileName}`);
  }
}

const index = JSON.parse(fs.readFileSync(path.join(creationDir, "index.json"), "utf8"));
for (const section of index.sections) {
  if (!fs.existsSync(path.join(creationDir, section.file))) {
    fail(`index referencia arquivo ausente: ${section.file}`);
  }
}

const abilityGen = JSON.parse(fs.readFileSync(path.join(creationDir, "ability-generation.json"), "utf8"));
const classIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8")).classes.map((c) => c.id)
);
const backgroundIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "backgrounds/index.json"), "utf8")).backgrounds.map(
    (b) => b.id
  )
);

for (const row of abilityGen.standardArrayByClass ?? []) {
  if (!classIds.has(row.classId)) fail(`standardArrayByClass: classe desconhecida ${row.classId}`);
}

for (const hint of abilityGen.backgroundPrimaryAbilityHints ?? []) {
  for (const bgId of hint.backgroundIds) {
    if (!backgroundIds.has(bgId)) fail(`backgroundPrimaryAbilityHints: antecedente ${bgId} inválido`);
  }
}

const langDoc = JSON.parse(fs.readFileSync(path.join(creationDir, "languages.json"), "utf8"));
const langIds = new Set(langDoc.languages.map((l) => l.id));
for (const row of langDoc.commonTable) {
  if (!langIds.has(row.languageId)) fail(`commonTable: idioma ${row.languageId} ausente em languages[]`);
}
for (const row of langDoc.rareLanguages ?? []) {
  if (!langIds.has(row.languageId)) fail(`rareLanguages: idioma ${row.languageId} ausente`);
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log("\n✓ Criação de personagem (Cap. 2) válida.");
process.exit(0);
