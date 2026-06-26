/**
 * Injeta preparedSpellSourceKey e tabelas de magia nos JSON de subclasse.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { SUBCLASS_SPELLS } from "./subclass-spell-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const subclassesDir = path.join(__dirname, "..", "data/phb/subclasses");

let updated = 0;

for (const [fileKey, spellData] of Object.entries(SUBCLASS_SPELLS)) {
  const filePath = path.join(subclassesDir, `${fileKey}.json`);
  if (!fs.existsSync(filePath)) {
    console.error(`✗ Arquivo ausente: ${fileKey}.json`);
    process.exit(1);
  }

  const doc = JSON.parse(fs.readFileSync(filePath, "utf8"));
  doc.preparedSpellSourceKey = spellData.preparedSpellSourceKey;

  if (spellData.preparedSpellsByLevel) {
    doc.preparedSpellsByLevel = spellData.preparedSpellsByLevel;
  }
  if (spellData.preparedSpellsByTerrain) {
    doc.preparedSpellsByTerrain = spellData.preparedSpellsByTerrain;
    doc.landTerrainIds = spellData.landTerrainIds;
  }

  fs.writeFileSync(filePath, `${JSON.stringify(doc, null, 2)}\n`, "utf8");
  updated++;
}

console.log(`✓ ${updated} subclasse(s) com magias estruturadas`);
process.exit(0);
