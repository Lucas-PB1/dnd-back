/**
 * Valida regras do Cap. 1/2 em data/phb/rules/ (schema + consistência cruzada).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";
import { HP_BY_CLASS } from "./hp-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const rulesDir = path.join(root, "data/phb/rules");
const phb = path.join(root, "data/phb");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);
ajv.addSchema(
  JSON.parse(fs.readFileSync(path.join(schemaDir, "equipment-entry.schema.json"), "utf8"))
);
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "class.schema.json"), "utf8")));

const ruleSchemas = [
  ["rules-index.schema.json", "index.json"],
  ["ability-modifiers.schema.json", "ability-modifiers.json"],
  ["proficiency-bonus.schema.json", "proficiency-bonus.json"],
  ["d20-tests.schema.json", "d20-tests.json"],
  ["ability-checks.schema.json", "ability-checks.json"],
  ["saving-throws.schema.json", "saving-throws.json"],
  ["hp-rules.schema.json", "hp.json"],
  ["character-advancement.schema.json", "character-advancement.json"],
];

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

for (const [schemaName, fileName] of ruleSchemas) {
  const schema = JSON.parse(fs.readFileSync(path.join(schemaDir, schemaName), "utf8"));
  const validate = ajv.compile(schema);
  const doc = JSON.parse(fs.readFileSync(path.join(rulesDir, fileName), "utf8"));
  if (!validate(doc)) {
    fail(`${fileName}: ${ajv.errorsText(validate.errors)}`);
  } else {
    console.log(`✓ rules/${fileName}`);
  }
}

const index = JSON.parse(fs.readFileSync(path.join(rulesDir, "index.json"), "utf8"));
for (const section of index.sections) {
  const p = path.join(rulesDir, section.file);
  if (!fs.existsSync(p)) fail(`index referencia arquivo ausente: ${section.file}`);
}

const proficiency = JSON.parse(
  fs.readFileSync(path.join(rulesDir, "proficiency-bonus.json"), "utf8")
);
const advancement = JSON.parse(
  fs.readFileSync(path.join(rulesDir, "character-advancement.json"), "utf8")
);

for (const row of advancement.levels) {
  const band = proficiency.byLevelOrCR.find(
    (b) => row.level >= b.levelMin && row.level <= b.levelMax
  );
  if (!band || band.bonus !== row.proficiencyBonus) {
    fail(
      `nível ${row.level}: proficiencyBonus ${row.proficiencyBonus} ≠ tabela Cap. 1 (${band?.bonus})`
    );
  }
}

const hpRules = JSON.parse(fs.readFileSync(path.join(rulesDir, "hp.json"), "utf8"));
const hpClassIds = new Set();
for (const group of [...hpRules.level1MaxHp, ...hpRules.fixedHpPerLevel]) {
  for (const id of group.classIds) hpClassIds.add(id);
}
const allClasses = JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8")).classes.map(
  (c) => c.id
);
for (const id of allClasses) {
  if (!hpClassIds.has(id)) fail(`classe ${id} ausente em hp.json`);
  if (!HP_BY_CLASS[id]) fail(`classe ${id} ausente em hp-data.mjs`);
}

for (const group of hpRules.level1MaxHp) {
  const dieVal = parseInt(group.hitDie.slice(1), 10);
  for (const id of group.classIds) {
    if (HP_BY_CLASS[id].level1Die !== dieVal) {
      fail(`${id}: level1Die ${HP_BY_CLASS[id].level1Die} ≠ ${group.hitDie} em hp.json`);
    }
  }
}

for (const file of fs.readdirSync(path.join(phb, "classes")).filter((f) => f.endsWith(".json"))) {
  const cls = JSON.parse(fs.readFileSync(path.join(phb, "classes", file), "utf8"));
  const expected = HP_BY_CLASS[cls.id];
  if (!expected) continue;
  if (!cls.hitPoints) {
    fail(`${cls.id}: falta hitPoints (rode npm run apply:hp)`);
    continue;
  }
  if (
    cls.hitPoints.level1DieValue !== expected.level1Die ||
    cls.hitPoints.fixedHpPerLevel !== expected.fixedPerLevel
  ) {
    fail(`${cls.id}: hitPoints inconsistente com hp-data`);
  }
}

const abilityIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")).abilities.map((a) => a.id)
);
for (const row of JSON.parse(fs.readFileSync(path.join(rulesDir, "ability-checks.json"), "utf8"))
  .byAbility) {
  if (!abilityIds.has(row.abilityId)) fail(`ability-checks: abilityId desconhecido ${row.abilityId}`);
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log("\n✓ Regras do Cap. 1/2 válidas (schema + cruzamentos).");
process.exit(0);
