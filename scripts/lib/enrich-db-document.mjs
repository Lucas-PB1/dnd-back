/**
 * Reconstrói metadados de feat ausentes em character_document (import descarta opções).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { GENERAL_FEAT_DEFS } from "../general-feat-mechanics-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "..", "data/phb");

function classSavingThrows(classId) {
  const doc = JSON.parse(
    fs.readFileSync(path.join(phb, "classes", `${classId}.json`), "utf8")
  );
  return doc.savingThrowIds ?? [];
}

/** Enriquece JSON de rpg.character_document para validação de regras. */
export function enrichDbDocument(doc, extras = {}) {
  if (!doc) return doc;

  if (extras.subclassChoices && Object.keys(extras.subclassChoices).length) {
    doc.subclassChoices = { ...(doc.subclassChoices ?? {}), ...extras.subclassChoices };
  }

  if (extras.spellbookClass?.length) {
    doc.spellcasting = doc.spellcasting ?? {};
    doc.spellcasting.spellbook = { class: extras.spellbookClass };
  }

  const classSaves = new Set(classSavingThrows(doc.classId));
  const sc = doc.spellcasting ?? {};

  for (const feat of doc.feats ?? []) {
    if (feat.featId === "resilient" && !feat.resilient?.abilityId) {
      const extra = (doc.savingThrowProficiencies ?? []).filter((id) => !classSaves.has(id));
      if (extra.length) feat.resilient = { abilityId: extra[0] };
    }

    if (feat.source !== "general") continue;
    const def = GENERAL_FEAT_DEFS[feat.featId];
    if (!def?.spells && !def?.ritualSpells) continue;

    const prepared = sc.prepared?.[feat.featId] ?? [];
    const cantrips = sc.cantrips?.[feat.featId] ?? [];
    if (!prepared.length && !cantrips.length) continue;

    feat.featSpells = {
      ...(cantrips.length ? { cantripIds: cantrips } : {}),
      ...(prepared.length ? { preparedSpellIds: prepared } : {}),
    };
    if (!feat.castingAbilityId && feat.asi?.abilityIds?.[0]) {
      feat.castingAbilityId = feat.asi.abilityIds[0];
    }
  }

  return doc;
}
