/**
 * Análise além do validate-character — confirma que as lacunas foram fechadas.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  expectedArmorClass,
  expectedMaxHpForCharacter,
  expectedPassivePerception,
} from "./character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const charsDir = path.join(__dirname, "..", "data/characters");

const files = fs.readdirSync(charsDir).filter((f) => f.endsWith(".json"));
let issues = 0;

for (const file of files) {
  const doc = JSON.parse(fs.readFileSync(path.join(charsDir, file), "utf8"));
  const hp = expectedMaxHpForCharacter(doc);
  if (doc.hp?.max !== hp) {
    console.error(`✗ ${doc.id}: PV ${doc.hp?.max} ≠ esperado ${hp}`);
    issues++;
  }
  const ac = expectedArmorClass(doc);
  if (doc.armorClass?.total !== ac.total) {
    console.error(`✗ ${doc.id}: CA ${doc.armorClass?.total} ≠ esperado ${ac.total}`);
    issues++;
  }
  const passive = expectedPassivePerception(doc);
  if (doc.passivePerception !== passive) {
    console.error(`✗ ${doc.id}: passiva ${doc.passivePerception} ≠ esperado ${passive}`);
    issues++;
  }
}

if (issues) {
  console.error(`\n${issues} inconsistência(s) interna(s).`);
  process.exit(1);
}

console.log(`✓ ${files.length} fichas coerentes com regras estendidas (PV, CA, passiva)`);
process.exit(0);
