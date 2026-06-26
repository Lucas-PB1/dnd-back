/**
 * Valida perícias individuais, índice e regras em data/phb/skills/.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";
import { SKILLS } from "./skill-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const skillsDir = path.join(root, "data/phb/skills");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);
ajv.addSchema(
  JSON.parse(fs.readFileSync(path.join(schemaDir, "equipment-entry.schema.json"), "utf8"))
);
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "class.schema.json"), "utf8")));

function compile(name) {
  return ajv.compile(JSON.parse(fs.readFileSync(path.join(schemaDir, name), "utf8")));
}

const validators = {
  index: compile("skills-index.schema.json"),
  skill: compile("skill.schema.json"),
  rules: compile("skill-rules.schema.json"),
};

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

function check(validator, label, doc) {
  if (!validator(doc)) {
    fail(`${label}: ${ajv.errorsText(validator.errors)}`);
    return false;
  }
  console.log(`✓ ${label}`);
  return true;
}

const index = JSON.parse(fs.readFileSync(path.join(skillsDir, "index.json"), "utf8"));
check(validators.index, "skills/index.json", index);

const abilityIds = new Set(index.abilities.map((a) => a.id));
const skillIds = new Set();

for (const entry of index.skills) {
  skillIds.add(entry.id);
  const filePath = path.join(skillsDir, entry.file);
  if (!fs.existsSync(filePath)) {
    fail(`arquivo ausente: ${entry.file}`);
    continue;
  }
  const doc = JSON.parse(fs.readFileSync(filePath, "utf8"));
  if (!check(validators.skill, `skills/${entry.file}`, doc)) continue;
  if (doc.id !== entry.id) fail(`${entry.file}: id ${doc.id} ≠ índice ${entry.id}`);
  if (doc.abilityId !== entry.ability) fail(`${entry.file}: abilityId ≠ índice`);
  if (!abilityIds.has(doc.abilityId)) fail(`${entry.file}: abilityId desconhecido`);
}

for (const expected of SKILLS) {
  if (!skillIds.has(expected.id)) fail(`perícia ausente no índice: ${expected.id}`);
}

for (const rule of index.rules ?? []) {
  const filePath = path.join(skillsDir, "rules", rule.file);
  if (!fs.existsSync(filePath)) {
    fail(`regra ausente: rules/${rule.file}`);
    continue;
  }
  const doc = JSON.parse(fs.readFileSync(filePath, "utf8"));
  check(validators.rules, `skills/rules/${rule.file}`, doc);
  for (const row of doc.bySkill ?? []) {
    if (!skillIds.has(row.skillId)) fail(`${rule.file}: skillId ${row.skillId} inválido`);
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(`\n✓ ${skillIds.size} perícias + ${index.rules?.length ?? 0} regras válidas.`);
process.exit(0);
