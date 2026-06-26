/**
 * Preenche propertyIds, masteryId e metadados estruturados em weapons.json
 * a partir das colunas legadas properties/mastery.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const weaponsPath = path.join(root, "data/phb/weapons/weapons.json");

const MASTERY_PT = {
  Afligir: "vex",
  Ágil: "nick",
  Derrubar: "topple",
  Drenar: "sap",
  Empurrar: "push",
  Garantido: "graze",
  Lentidão: "slow",
  Trespassar: "cleave",
};

function parseProperties(raw) {
  if (!raw || raw === "—") {
    return { propertyIds: [], range: null, versatileDamage: null, ammunitionType: null };
  }

  const propertyIds = [];
  let range = null;
  let versatileDamage = null;
  let ammunitionType = null;

  const parts = raw
    .split(",")
    .map((p) => p.trim())
    .filter(Boolean);

  for (const part of parts) {
    if (part.startsWith("Acuidade")) {
      propertyIds.push("finesse");
      continue;
    }
    if (part.startsWith("Leve")) {
      propertyIds.push("light");
      continue;
    }
    if (part.startsWith("Extensão")) {
      propertyIds.push("reach");
      continue;
    }
    if (part.startsWith("Pesada")) {
      propertyIds.push("heavy");
      continue;
    }
    if (part.startsWith("Recarga")) {
      propertyIds.push("loading");
      continue;
    }
    if (part.startsWith("Duas Mãos")) {
      propertyIds.push("two-handed");
      continue;
    }
    if (part.startsWith("Versátil")) {
      propertyIds.push("versatile");
      const m = part.match(/\(([^)]+)\)/);
      if (m) versatileDamage = m[1];
      continue;
    }
    if (part.startsWith("Arremesso")) {
      propertyIds.push("thrown");
      const m = part.match(/Alcance\s+([\d,]+)\/([\d,]+)/);
      if (m) {
        range = {
          normal: Number(m[1].replace(",", ".")),
          max: Number(m[2].replace(",", ".")),
        };
      }
      continue;
    }
    if (part.startsWith("Munição")) {
      propertyIds.push("ammunition");
      const rangeMatch = part.match(/Alcance\s+([\d,]+)\/([\d,]+)/);
      if (rangeMatch) {
        range = {
          normal: Number(rangeMatch[1].replace(",", ".")),
          max: Number(rangeMatch[2].replace(",", ".")),
        };
      }
      const ammoMatch = part.match(/;\s*([^)]+)\)?$/);
      if (ammoMatch) ammunitionType = ammoMatch[1].trim();
      continue;
    }
  }

  return {
    propertyIds: [...new Set(propertyIds)],
    range,
    versatileDamage,
    ammunitionType,
  };
}

const doc = JSON.parse(fs.readFileSync(weaponsPath, "utf8"));

for (const weapon of doc.weapons) {
  const parsed = parseProperties(weapon.properties);
  weapon.propertyIds = parsed.propertyIds;
  weapon.masteryId = MASTERY_PT[weapon.mastery] ?? null;

  if (parsed.range) weapon.range = parsed.range;
  else delete weapon.range;

  if (parsed.versatileDamage) weapon.versatileDamage = parsed.versatileDamage;
  else delete weapon.versatileDamage;

  if (parsed.ammunitionType) weapon.ammunitionType = parsed.ammunitionType;
  else delete weapon.ammunitionType;

  if (!weapon.masteryId) {
    throw new Error(`${weapon.id}: maestria desconhecida "${weapon.mastery}"`);
  }
}

fs.writeFileSync(weaponsPath, `${JSON.stringify(doc, null, 2)}\n`, "utf8");
console.log(`✓ ${doc.weapons.length} armas estruturadas em weapons.json`);
