/**
 * Valida schemas do PHB após normalização de ids (antecedentes, classes, perícias).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const phb = path.join(root, "data/phb");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);

const equipmentEntrySchema = JSON.parse(
  fs.readFileSync(path.join(schemaDir, "equipment-entry.schema.json"), "utf8")
);
ajv.addSchema(equipmentEntrySchema);
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "class.schema.json"), "utf8")));

function compile(name) {
  const schema = JSON.parse(fs.readFileSync(path.join(schemaDir, name), "utf8"));
  return ajv.compile(schema);
}

const validators = {
  skills: compile("skills-index.schema.json"),
  background: compile("background.schema.json"),
  class: ajv.getSchema("https://rpg.local/schema/class.schema.json"),
};

let errors = 0;
function check(validator, file, doc) {
  if (!validator(doc)) {
    console.error(`✗ ${file}: ${ajv.errorsText(validator.errors)}`);
    errors++;
    return false;
  }
  return true;
}

check(
  validators.skills,
  "skills/index.json",
  JSON.parse(fs.readFileSync(path.join(phb, "skills/index.json"), "utf8"))
);

for (const f of fs
  .readdirSync(path.join(phb, "backgrounds"))
  .filter((x) => x.endsWith(".json") && x !== "index.json")) {
  check(
    validators.background,
    `backgrounds/${f}`,
    JSON.parse(fs.readFileSync(path.join(phb, "backgrounds", f), "utf8"))
  );
}

const classFiles = JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8")).classes.map(
  (c) => path.basename(c.file)
);
for (const f of classFiles) {
  check(
    validators.class,
    `classes/${f}`,
    JSON.parse(fs.readFileSync(path.join(phb, "classes", f), "utf8"))
  );
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log("✓ Referências PHB válidas (skills, 16 antecedentes, 12 classes)");
process.exit(0);
