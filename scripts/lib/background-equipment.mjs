/**
 * Equipamento inicial de antecedente (PHB 2024).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { categorySlugFromName } from "./tool-categories.mjs";
import { resolveBackgroundToolId, toolsForCategoryName } from "./background-tool-benefits.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "..", "data/phb");

function loadBackground(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "backgrounds", `${id}.json`), "utf8"));
}

function hashSeed(str) {
  let h = 0;
  for (let i = 0; i < str.length; i++) h = (h * 31 + str.charCodeAt(i)) | 0;
  return Math.abs(h);
}

/** Escolhas textuais de pacotes de antecedente → itens concretos. */
const BACKGROUND_PACKAGE_CHOICES = {
  "2 Adagas": [{ itemId: "dagger", quantity: 2 }],
  "2 adagas": [{ itemId: "dagger", quantity: 2 }],
  "2 Algibeiras": [{ itemId: "algibeira", quantity: 2 }],
  "20 Virotes": [{ itemId: "estojo-virote-de-besta", quantity: 1 }],
  "2 Fantasias": [{ itemId: "roupas-fantasia", quantity: 2 }],
  "20 Flechas": [],
  "Ferramentas de Artesão (a mesma que acima)": "bg-tool",
  "Instrumento Musical (o mesmo que acima)": "bg-tool",
  "Kit de Jogo (o mesmo que acima)": "bg-tool",
  "Kit de Jogos (o mesmo que acima)": "bg-tool",
  "Kit de Jogos (qualquer um)": "kit-category",
};

function resolveKitFromCategory(doc) {
  const pool = toolsForCategoryName("Kit de Jogos");
  if (!pool.length) return null;
  return pool[hashSeed(`${doc.id}:bg-kit-equip`) % pool.length];
}

function resolveChoiceItems(doc, background, choiceText) {
  const mapped = BACKGROUND_PACKAGE_CHOICES[choiceText];
  if (mapped === "bg-tool") {
    const toolId = resolveBackgroundToolId(doc, background);
    return toolId ? [{ itemId: toolId, quantity: 1 }] : [];
  }
  if (mapped === "kit-category") {
    const toolId = resolveKitFromCategory(doc);
    return toolId ? [{ itemId: toolId, quantity: 1 }] : [];
  }
  if (Array.isArray(mapped)) return mapped;
  return [];
}

function backgroundPackage(doc, bg = null) {
  const background = bg ?? loadBackground(doc.backgroundId);
  const pkgId = doc.startingPackages?.backgroundOption ?? "a";
  return background.equipment?.packages?.find((p) => p.id === pkgId) ?? null;
}

/** Itens permitidos no pacote do antecedente (validação). */
export function backgroundPackageAllowedItemIds(doc, pkg) {
  const bg = loadBackground(doc.backgroundId);
  const ids = new Set();
  for (const entry of pkg?.items ?? []) {
    if (entry.id) ids.add(entry.id);
    else if (entry.choice) {
      for (const item of resolveChoiceItems(doc, bg, entry.choice)) {
        ids.add(item.itemId);
      }
    }
  }
  return ids;
}

/** Lista esperada de itens background-starting (itemId + quantity). */
export function expectedBackgroundStartingEquipment(doc, bg = null) {
  const background = bg ?? loadBackground(doc.backgroundId);
  const pkg = backgroundPackage(doc, background);
  if (!pkg) return [];

  const items = [];
  for (const entry of pkg.items ?? []) {
    if (entry.id) {
      items.push({ itemId: entry.id, quantity: entry.quantity ?? 1 });
      continue;
    }
    if (entry.choice) {
      for (const item of resolveChoiceItems(doc, background, entry.choice)) {
        items.push({ itemId: item.itemId, quantity: item.quantity ?? 1 });
      }
    }
  }
  return items;
}

function equipmentQuantityMap(entries) {
  const map = new Map();
  for (const entry of entries) {
    const qty = entry.quantity ?? 1;
    map.set(entry.itemId, (map.get(entry.itemId) ?? 0) + qty);
  }
  return map;
}

/** Exige que todos os itens do pacote do antecedente estejam em doc.equipment. */
export function validateBackgroundStartingEquipmentPresent(doc) {
  const bg = loadBackground(doc.backgroundId);
  const expected = expectedBackgroundStartingEquipment(doc, bg);
  const got = (doc.equipment ?? [])
    .filter((e) => e.source === "background-starting")
    .map((e) => ({ itemId: e.itemId, quantity: e.quantity ?? 1 }));

  const expMap = equipmentQuantityMap(expected);
  const gotMap = equipmentQuantityMap(got);

  for (const [itemId, qty] of expMap) {
    const have = gotMap.get(itemId) ?? 0;
    if (have < qty) {
      return {
        ok: false,
        reason: `equipamento de antecedente ausente: ${itemId} (tem ${have}, esperado ${qty})`,
      };
    }
  }

  for (const [itemId, qty] of gotMap) {
    const need = expMap.get(itemId) ?? 0;
    if (qty > need) {
      return {
        ok: false,
        reason: `equipamento de antecedente extra: ${itemId} (tem ${qty}, esperado ${need})`,
      };
    }
  }

  return { ok: true };
}

/** Adiciona itens do pacote A (ou backgroundOption) com source background-starting. */
export function applyBackgroundStartingEquipment(doc, bg = null) {
  const background = bg ?? loadBackground(doc.backgroundId);
  const pkg = backgroundPackage(doc, background);
  if (!pkg) return;

  const equipment = [...(doc.equipment ?? [])];
  for (const entry of pkg.items ?? []) {
    if (entry.id) {
      equipment.push({
        itemId: entry.id,
        source: "background-starting",
        quantity: entry.quantity ?? 1,
      });
      continue;
    }
    if (entry.choice) {
      for (const item of resolveChoiceItems(doc, background, entry.choice)) {
        equipment.push({
          itemId: item.itemId,
          source: "background-starting",
          quantity: item.quantity ?? 1,
        });
      }
    }
  }
  doc.equipment = equipment;
}

export { BACKGROUND_PACKAGE_CHOICES };
