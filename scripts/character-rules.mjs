/**
 * Regras derivadas para validar fichas contra progression e features do PHB.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const phb = path.join(root, "data/phb");

/** Magias sempre preparadas do Domínio da Vida por nível de clérigo. */
export const LIFE_DOMAIN_PREPARED = {
  3: ["auxilio", "bencao", "curar-ferimentos", "restauracao-menor"],
  5: ["palavra-curativa-em-massa", "revivificar"],
  7: ["aura-de-vida", "protecao-contra-a-morte"],
  9: ["curar-ferimentos-em-massa", "restauracao-maior"],
};

/** Magia de linhagem élfica por nível (além do truque de nível 1). */
export const ELF_LINEAGE_SPELLS = {
  "high-elf": { 1: ["prestidigitacao-arcana"], 3: ["detectar-magia"], 5: ["passo-nebuloso"] },
  drow: { 1: ["luzes-dancantes"], 3: ["fogo-das-fadas"], 5: ["escuridao"] },
  "wood-elf": { 1: ["arte-druidica"], 3: ["passos-largos"], 5: ["passo-sem-rastro"] },
};

export function abilityMod(score) {
  return Math.floor((score - 10) / 2);
}

export function expectedClassCantrips(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.cantrips ?? null;
}

export function expectedPreparedCount(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.preparedSpells ?? null;
}

export function expectedSpellSlots(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  if (!row) return null;
  if (classId === "warlock") {
    return row.pactSlots ? { [String(row.pactSlotLevel)]: row.pactSlots } : null;
  }
  return row.spellSlots ?? null;
}

export function expectedChannelDivinity(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.channelDivinity ?? null;
}

export function lineagePreparedSpells(lineageId, level) {
  const table = ELF_LINEAGE_SPELLS[lineageId];
  if (!table) return [];
  const spells = [];
  if (level >= 3 && table[3]) spells.push(...table[3]);
  if (level >= 5 && table[5]) spells.push(...table[5]);
  return spells;
}

export function lineageCantrips(lineageId) {
  return ELF_LINEAGE_SPELLS[lineageId]?.[1] ?? [];
}

export function loadBackground(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "backgrounds", `${id}.json`), "utf8"));
}

export function loadClass(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "classes", `${id}.json`), "utf8"));
}

export function loadSubclass(classId, subclassId) {
  return JSON.parse(
    fs.readFileSync(path.join(phb, "subclasses", `${classId}-${subclassId}.json`), "utf8")
  );
}

export function allCantripIds(character) {
  return Object.values(character.spellcasting.cantrips).flat();
}

export function allPreparedIds(character) {
  return Object.values(character.spellcasting.prepared).flat();
}
