/**
 * Normaliza referências por id em antecedentes e classes.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { toAbilityId, toSkillId } from "./skill-map.mjs";
import { parseEquipmentString, parseGoldOption } from "./item-name-map.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

function parseAbilityIds(text) {
  return text.split(/\s+(?:e|ou)\s+/).map(toAbilityId);
}

function transformItems(strings) {
  return strings.map((s) => parseEquipmentString(s));
}

function transformBackground(file) {
  const doc = JSON.parse(fs.readFileSync(file, "utf8"));

  if (!doc.skillIds) {
    doc.skillIds = doc.skills.map(toSkillId);
    delete doc.skills;
  }

  if (doc.toolProficiency.kind === "fixed" && !doc.toolProficiency.itemId) {
    doc.toolProficiency.itemId = parseEquipmentString(doc.toolProficiency.description).id;
  }

  if (typeof doc.equipment.goldOption === "string") {
    doc.equipment = {
      goldOption: parseGoldOption(doc.equipment.goldOption),
      packages: doc.equipment.packages.map((pkg) => ({
        ...pkg,
        items:
          typeof pkg.items[0] === "string" ? transformItems(pkg.items) : pkg.items,
        gold: pkg.gold
          ? typeof pkg.gold === "string"
            ? parseGoldOption(pkg.gold)
            : pkg.gold
          : undefined,
      })),
    };
  }

  fs.writeFileSync(file, JSON.stringify(doc, null, 2) + "\n");
  console.log(`✓ ${path.basename(file)}`);
}

function transformClass(file) {
  const doc = JSON.parse(fs.readFileSync(file, "utf8"));

  if (!doc.primaryAbilityId && !doc.primaryAbilityIds) {
    const ids = parseAbilityIds(doc.primaryAbility);
    if (ids.length === 1) doc.primaryAbilityId = ids[0];
    else doc.primaryAbilityIds = ids;
  }

  if (!doc.savingThrowIds) {
    doc.savingThrowIds = doc.savingThrows.map(toAbilityId);
    delete doc.savingThrows;
  }

  if (doc.skillChoices?.from && Array.isArray(doc.skillChoices.from)) {
    doc.skillChoices.skillIds = doc.skillChoices.from.map(toSkillId);
    delete doc.skillChoices.from;
  }

  if (doc.startingEquipment?.options) {
    doc.startingEquipment.options = doc.startingEquipment.options.map((opt) => ({
      ...opt,
      items:
        opt.items.length && typeof opt.items[0] === "string"
          ? transformItems(opt.items)
          : opt.items,
    }));
  }

  if (doc.spellcasting?.focus && !doc.spellcasting.focusItemId) {
    try {
      const parsed = parseEquipmentString(doc.spellcasting.focus);
      if (parsed.id) doc.spellcasting.focusItemId = parsed.id;
    } catch {
      /* foco em texto livre */
    }
  }

  fs.writeFileSync(file, JSON.stringify(doc, null, 2) + "\n");
  console.log(`✓ ${path.basename(file)}`);
}

const bgDir = path.join(root, "data/phb/backgrounds");
for (const f of fs.readdirSync(bgDir).filter((x) => x.endsWith(".json") && x !== "index.json")) {
  transformBackground(path.join(bgDir, f));
}

const classDir = path.join(root, "data/phb/classes");
for (const f of fs.readdirSync(classDir).filter((x) => x.endsWith(".json"))) {
  transformClass(path.join(classDir, f));
}

console.log("✓ Referências normalizadas");
