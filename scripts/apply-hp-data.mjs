/**
 * Aplica hitPoints derivado de hp.json / HP_BY_CLASS em cada classe.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { HP_BY_CLASS } from "./hp-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const classesDir = path.join(__dirname, "../data/phb/classes");

for (const file of fs.readdirSync(classesDir).filter((f) => f.endsWith(".json"))) {
  const filePath = path.join(classesDir, file);
  const doc = JSON.parse(fs.readFileSync(filePath, "utf8"));
  const hp = HP_BY_CLASS[doc.id];
  if (!hp) {
    console.error(`✗ Sem dados de PV para ${doc.id}`);
    process.exit(1);
  }
  const dieFromHitDie = parseInt(doc.hitDie.slice(1), 10);
  if (dieFromHitDie !== hp.level1Die) {
    console.error(
      `✗ ${doc.id}: hitDie ${doc.hitDie} ≠ level1Die esperado ${hp.level1Die}`
    );
    process.exit(1);
  }
  doc.hitPoints = {
    level1DieValue: hp.level1Die,
    fixedHpPerLevel: hp.fixedPerLevel,
    minimumGainPerLevel: 1,
    constitutionModApplies: true,
  };
  fs.writeFileSync(filePath, `${JSON.stringify(doc, null, 2)}\n`, "utf8");
  console.log(`✓ ${doc.id}`);
}

console.log("hitPoints aplicado nas 12 classes.");
