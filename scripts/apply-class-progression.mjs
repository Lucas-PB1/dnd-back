/**
 * Adiciona `progression` aos JSON de classes conjuradoras.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const classesDir = path.join(__dirname, "..", "data/phb/classes");

for (const [classId, progression] of Object.entries(CLASS_PROGRESSION)) {
  const filePath = path.join(classesDir, `${classId}.json`);
  const doc = JSON.parse(fs.readFileSync(filePath, "utf8"));
  doc.progression = progression;
  fs.writeFileSync(filePath, JSON.stringify(doc, null, 2) + "\n");
  console.log(`✓ ${classId}.json — progression (${progression.levels.length} níveis)`);
}
