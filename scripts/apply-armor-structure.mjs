/**
 * Preenche acFormula, propertyIds e strengthMinimum em armor.json.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const armorPath = path.join(__dirname, "..", "data/phb/armor/armor.json");

function parseStrength(raw) {
  if (!raw) return null;
  const m = raw.match(/(\d+)/);
  return m ? Number(m[1]) : null;
}

function parseAc(ac, category) {
  if (category === "shield" || ac.startsWith("+")) {
    return { type: "shield-bonus", bonus: Number(ac.replace("+", "")) };
  }
  if (/^\d+$/.test(ac.trim())) {
    return { type: "fixed", base: Number(ac.trim()) };
  }
  const baseMatch = ac.match(/^(\d+)/);
  const base = baseMatch ? Number(baseMatch[1]) : 10;
  const dexMaxMatch = ac.match(/m[aá]x\.?\s*(\d+)/i);
  return {
    type: "dex-plus-base",
    base,
    ...(dexMaxMatch ? { dexMax: Number(dexMaxMatch[1]) } : {}),
  };
}

const doc = JSON.parse(fs.readFileSync(armorPath, "utf8"));

for (const item of doc.items) {
  item.acFormula = parseAc(item.ac, item.category);
  item.propertyIds = [];

  if (item.stealthDisadvantage) item.propertyIds.push("stealth-disadvantage");

  const strengthMinimum = parseStrength(item.strength);
  if (strengthMinimum != null) {
    item.strengthMinimum = strengthMinimum;
    item.propertyIds.push("strength-requirement");
  } else {
    delete item.strengthMinimum;
  }

  if (item.category === "shield") {
    item.propertyIds.push("shield-ac-bonus");
  }
}

fs.writeFileSync(armorPath, `${JSON.stringify(doc, null, 2)}\n`, "utf8");
console.log(`✓ ${doc.items.length} armaduras estruturadas em armor.json`);
