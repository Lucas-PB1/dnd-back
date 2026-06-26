/**
 * Catálogo de itens do PHB (nome PT → id) e parser de strings de equipamento inicial.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const phb = path.join(root, "data/phb");

/** Nomes no livro que diferem do catálogo ou precisam de alias. */
export const ITEM_NAME_OVERRIDES = {
  "Kit Sacerdotal": "kit-de-sacerdote",
  "Kit de Druida": "foco-druidico",
  "Kit de Explorador": "kit-de-explorador-de-masmorras",
  "Kit de Ladrão": "kit-de-assaltante",
  "Armadura de Couro": "leather",
  "Balde de Ferro": "balde",
  "Aljava com 20 Flechas": "aljava",
  "Aljava com 20 Virotes": "aljava",
  "Foco Arcano (orbe)": "foco-arcano",
  "Livro (orações)": "livro",
  "Livro (conhecimento oculto)": "livro",
  "Livro (filosofia)": "livro",
  "Livro (história)": "livro",
  "Pergaminho (10 folhas)": "pergaminho",
  "Pergaminho (12 folhas)": "pergaminho",
  "Pergaminho (8 folhas)": "pergaminho",
  "Óleo (3 frascos)": "oleo",
  "Roupas Finas": "roupas-finas",
  "Roupas de Viagem": "roupas-viagem",
  Fantasia: "roupas-fantasia",
  "Ferramentas de Carpinteiro": "ferramentas-de-carpinteiro",
  "Ferramentas de Cartógrafo": "ferramentas-de-cartografo",
  "Ferramentas de Ladrão": "ferramentas-de-ladrao",
  "Ferramentas de Navegador": "ferramentas-de-navegador",
  "Suprimentos de Calígrafo": "suprimentos-de-caligrafo",
  "Pé de Cabra": "pe-de-cabra",
  Dardos: "dart",
  Dardo: "dart",
};

const CHOICE_PATTERN =
  /\(escolha\)|\(qualquer|\(o mesmo|\(a mesma|Ferramentas de Artesão/i;

function loadCatalog() {
  const byName = new Map();

  function add(id, name) {
    if (!byName.has(name)) byName.set(name, id);
  }

  const weapons = JSON.parse(
    fs.readFileSync(path.join(phb, "weapons/weapons.json"), "utf8")
  );
  for (const w of weapons.weapons) add(w.id, w.name);

  const armor = JSON.parse(fs.readFileSync(path.join(phb, "armor/armor.json"), "utf8"));
  for (const a of armor.items) add(a.id, a.name);

  const gear = JSON.parse(
    fs.readFileSync(path.join(phb, "equipment/gear/adventuring-gear.json"), "utf8")
  );
  for (const g of gear.items) add(g.id, g.name);

  for (const file of ["equipment/tools/artisan.json", "equipment/tools/other.json"]) {
    const doc = JSON.parse(fs.readFileSync(path.join(phb, file), "utf8"));
    for (const t of doc.tools ?? []) add(t.id, t.name);
  }

  for (const [name, id] of Object.entries(ITEM_NAME_OVERRIDES)) {
    byName.set(name, typeof id === "string" ? id : id);
  }

  return byName;
}

export const ITEM_NAME_TO_ID = loadCatalog();

export function parseEquipmentString(raw) {
  const text = raw.trim();
  const goldMatch = text.match(/^(\d+)\s*PO$/i);
  if (goldMatch) return { gold: Number(goldMatch[1]) };

  if (CHOICE_PATTERN.test(text)) return { choice: text };

  const qtyMatch = text.match(/^(\d+)\s+(.+)$/);
  const quantity = qtyMatch ? Number(qtyMatch[1]) : 1;
  const name = qtyMatch ? qtyMatch[2] : text;

  const override = ITEM_NAME_OVERRIDES[name];
  const id = typeof override === "string" ? override : ITEM_NAME_TO_ID.get(name);

  if (!id) {
    return { choice: text };
  }

  const entry = { id };
  if (quantity > 1) entry.quantity = quantity;
  return entry;
}

export function parseGoldOption(text) {
  const m = text.trim().match(/^(\d+)\s*PO$/i);
  if (!m) throw new Error(`goldOption inválido: ${text}`);
  return Number(m[1]);
}
