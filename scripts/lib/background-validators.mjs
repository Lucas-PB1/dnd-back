/**
 * Validadores agregados de antecedente (PHB 2024).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { validateBackgroundToolProficiency } from "./background-tool-benefits.mjs";
import { validateBackgroundStartingEquipmentPresent } from "./background-equipment.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "..", "data/phb");

function loadBackground(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "backgrounds", `${id}.json`), "utf8"));
}

const BACKGROUND_INDEX = JSON.parse(
  fs.readFileSync(path.join(phb, "backgrounds/index.json"), "utf8")
);

export const BACKGROUND_IDS = BACKGROUND_INDEX.backgrounds.map((b) => b.id);

/** Validadores de antecedente aplicáveis a ficha completa (memória ou document). */
export const BACKGROUND_CHARACTER_VALIDATORS = [
  validateBackgroundFeat,
  validateBackgroundSkills,
  validateBackgroundToolProficiency,
  validateBackgroundStartingEquipmentPresent,
  validateBackgroundChoices,
];

export function validateBackgroundFeat(doc) {
  const bg = loadBackground(doc.backgroundId);
  const featId = bg.feat?.id;
  if (!featId) return { ok: true };

  const match = (doc.feats ?? []).find((f) => f.featId === featId && f.source === "background");
  if (!match) {
    return { ok: false, reason: `feat de origem ${featId} ausente (source background)` };
  }
  return { ok: true };
}

export function validateBackgroundSkills(doc) {
  const bg = loadBackground(doc.backgroundId);
  const skills = doc.skillProficiencies ?? [];

  for (const skillId of bg.skillIds ?? []) {
    const entry = skills.find((s) => s.skillId === skillId);
    if (!entry) {
      return { ok: false, reason: `perícia de antecedente ausente: ${skillId}` };
    }
    if (entry.source !== "background") {
      return { ok: false, reason: `${skillId} deveria ter source background` };
    }
  }
  return { ok: true };
}

export function validateBackgroundChoices(doc) {
  const bg = loadBackground(doc.backgroundId);
  const toolCfg = bg.toolProficiency ?? {};
  if (toolCfg.kind !== "choice") return { ok: true };

  const chosen = doc.backgroundChoices?.toolId;
  if (!chosen) {
    return { ok: false, reason: "backgroundChoices.toolId ausente (antecedente choice)" };
  }

  const expected = doc.backgroundChoices.toolId;
  const bgTools = (doc.toolProficiencies ?? []).filter((t) => t.source === "background");
  if (!bgTools.some((t) => t.toolId === expected)) {
    return { ok: false, reason: `backgroundChoices.toolId ${expected} não está em toolProficiencies` };
  }
  return { ok: true };
}

export function validateBackgroundCharacter(doc) {
  for (const fn of BACKGROUND_CHARACTER_VALIDATORS) {
    const result = fn(doc);
    if (!result.ok) {
      return { ok: false, reason: result.reason, validator: fn.name };
    }
  }
  return { ok: true };
}

/** Valida estrutura mínima de cada JSON de antecedente no PHB. */
export function validateBackgroundCatalogJson() {
  const errors = [];
  for (const meta of BACKGROUND_INDEX.backgrounds) {
    const bg = loadBackground(meta.id);
    if (!bg.feat?.id) errors.push(`${meta.id}: feat ausente`);
    if ((bg.skillIds ?? []).length !== 2) {
      errors.push(`${meta.id}: esperadas 2 skillIds, tem ${(bg.skillIds ?? []).length}`);
    }
    if (!bg.toolProficiency?.kind) errors.push(`${meta.id}: toolProficiency ausente`);
    if (bg.toolProficiency?.kind === "fixed" && !bg.toolProficiency.itemId) {
      errors.push(`${meta.id}: toolProficiency fixed sem itemId`);
    }
    if (bg.toolProficiency?.kind === "choice" && !bg.toolProficiency.category) {
      errors.push(`${meta.id}: toolProficiency choice sem category`);
    }
    const pkg = bg.equipment?.packages?.find((p) => p.id === "a");
    if (!pkg?.items?.length) errors.push(`${meta.id}: pacote de equipamento a ausente`);
    if (meta.featId && bg.feat?.id !== meta.featId) {
      errors.push(`${meta.id}: featId index≠JSON (${meta.featId}≠${bg.feat?.id})`);
    }
  }
  return errors;
}
