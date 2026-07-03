/**
 * Benefícios passivos de talentos — ferramentas, perícias, equipamento (PHB 2024).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { effectiveArmorTrainingWithFeats } from "./general-feat-mechanics-data.mjs";
import {
  expectedBackgroundToolProficiencies,
} from "./lib/background-tool-benefits.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "data/phb");

export const FEAT_TOOL_GRANTS = {
  chef: ["utensilios-de-cozinheiro"],
  poisoner: ["kit-de-veneno"],
  actor: ["kit-de-disfarce"],
  healer: ["kit-de-curandeiro"],
};

const FEAT_SKILL_OR_EXPERTISE = {
  observant: {
    pool: ["insight", "investigation", "perception"],
    preferred: ["perception"],
  },
  "keen-mind": {
    pool: ["arcana", "history", "investigation", "nature", "religion"],
    preferred: ["investigation"],
  },
};

const SKILL_EXPERT_PROFICIENCY_PREFERRED = [
  "stealth",
  "perception",
  "arcana",
  "investigation",
  "athletics",
  "survival",
];

const SKILL_EXPERT_EXPERTISE_PREFERRED = [
  "stealth",
  "perception",
  "arcana",
  "investigation",
  "insight",
  "survival",
];

let cachedSkillIds = null;

function allSkillIds() {
  if (!cachedSkillIds) {
    cachedSkillIds = JSON.parse(
      fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")
    ).skills.map((s) => s.id);
  }
  return cachedSkillIds;
}

function hashSeed(str) {
  let h = 0;
  for (let i = 0; i < str.length; i++) h = (h * 31 + str.charCodeAt(i)) | 0;
  return Math.abs(h);
}

function pickFromOrdered(pool, preferred, seed) {
  const ordered = [
    ...preferred.filter((id) => pool.includes(id)),
    ...pool.filter((id) => !preferred.includes(id)),
  ];
  if (!ordered.length) return null;
  return ordered[seed % ordered.length];
}

function proficientSkillIds(doc) {
  return new Set((doc.skillProficiencies ?? []).map((s) => s.skillId));
}

function addSkillIfMissing(doc, skillId) {
  if (!skillId) return;
  const skills = doc.skillProficiencies ?? [];
  if (skills.some((s) => s.skillId === skillId)) return;
  skills.push({ skillId, source: "feat" });
  doc.skillProficiencies = skills;
}

export function applyFeatSkillBenefits(doc) {
  const seed = hashSeed(doc.id ?? "0");
  const proficient = proficientSkillIds(doc);

  for (const feat of doc.feats ?? []) {
    if (feat.source !== "general") continue;

    const skillCfg = FEAT_SKILL_OR_EXPERTISE[feat.featId];
    if (skillCfg) {
      const skillId = pickFromOrdered(skillCfg.pool, skillCfg.preferred, seed + feat.featId.length);
      if (skillId) {
        feat.featSkillChoice = { skillId };
        if (!proficient.has(skillId)) {
          addSkillIfMissing(doc, skillId);
          proficient.add(skillId);
        }
      }
    }

    if (feat.featId === "skill-expert") {
      const notProficient = allSkillIds().filter((id) => !proficient.has(id));
      const profSkill = pickFromOrdered(
        notProficient.length ? notProficient : [...proficient],
        SKILL_EXPERT_PROFICIENCY_PREFERRED,
        seed + 17
      );
      if (profSkill && !proficient.has(profSkill)) {
        addSkillIfMissing(doc, profSkill);
        proficient.add(profSkill);
      }

      const expertisePool = [...proficient];
      const expertiseSkill = pickFromOrdered(expertisePool, SKILL_EXPERT_EXPERTISE_PREFERRED, seed + 31);
      if (expertiseSkill) {
        feat.skillExpert = {
          proficiencySkillId: profSkill ?? expertiseSkill,
          expertiseSkillId: expertiseSkill,
        };
      }
    }
  }
}

export function applyFeatToolProficiencies(doc) {
  const tools = [...(doc.toolProficiencies ?? [])];
  const have = new Set(tools.map((t) => t.toolId));

  for (const feat of doc.feats ?? []) {
    const source = feat.source === "general" ? "general" : "background";
    for (const toolId of FEAT_TOOL_GRANTS[feat.featId] ?? []) {
      if (have.has(toolId)) continue;
      tools.push({ toolId, source });
      have.add(toolId);
    }
  }

  if (tools.length) doc.toolProficiencies = tools;
}

export function ensureShieldMasterEquipment(doc) {
  const hasFeat = doc.feats?.some((f) => f.featId === "shield-master" && f.source === "general");
  if (!hasFeat) return;

  const training = effectiveArmorTrainingWithFeats(doc);
  if (!training.shields) return;

  const equipment = [...(doc.equipment ?? [])];
  const shieldEquipped = equipment.some((e) => e.equipped && e.slot === "shield");
  if (shieldEquipped) return;

  const shieldIdx = equipment.findIndex((e) => e.itemId === "shield");
  if (shieldIdx >= 0) {
    equipment[shieldIdx] = { ...equipment[shieldIdx], equipped: true, slot: "shield" };
  } else {
    equipment.push({
      itemId: "shield",
      source: "other",
      equipped: true,
      slot: "shield",
    });
  }
  doc.equipment = equipment;
}

/** Aplica ferramentas, perícias de talento e ajustes de equipamento. */
export function applyFeatPassiveBenefits(doc) {
  applyFeatToolProficiencies(doc);
  applyFeatSkillBenefits(doc);
  ensureShieldMasterEquipment(doc);
}

export function expectedGeneralFeatToolProficiencies(doc) {
  const tools = [];
  const have = new Set();
  for (const feat of doc.feats ?? []) {
    if (feat.source !== "general") continue;
    for (const toolId of FEAT_TOOL_GRANTS[feat.featId] ?? []) {
      if (have.has(toolId)) continue;
      tools.push({ toolId, source: "general" });
      have.add(toolId);
    }
  }
  return tools;
}

export function expectedToolProficiencies(doc) {
  const tools = [];
  const have = new Set();
  const addAll = (list) => {
    for (const t of list) {
      if (have.has(t.toolId)) continue;
      tools.push(t);
      have.add(t.toolId);
    }
  };
  addAll(expectedBackgroundToolProficiencies(doc));
  for (const feat of doc.feats ?? []) {
    if (feat.source !== "background") continue;
    for (const toolId of FEAT_TOOL_GRANTS[feat.featId] ?? []) {
      if (have.has(toolId)) continue;
      tools.push({ toolId, source: "background" });
      have.add(toolId);
    }
  }
  addAll(expectedGeneralFeatToolProficiencies(doc));
  return tools;
}

export function validateToolProficiencies(doc) {
  const expected = expectedToolProficiencies(doc);
  const got = [...(doc.toolProficiencies ?? [])].sort((a, b) =>
    `${a.toolId}:${a.source}`.localeCompare(`${b.toolId}:${b.source}`)
  );
  const exp = [...expected].sort((a, b) =>
    `${a.toolId}:${a.source}`.localeCompare(`${b.toolId}:${b.source}`)
  );

  if (got.length !== exp.length) {
    return {
      ok: false,
      reason: `ferramentas=${got.map((t) => t.toolId).join(",")}, esperado ${exp.map((t) => t.toolId).join(",")}`,
    };
  }
  for (let i = 0; i < exp.length; i++) {
    if (got[i].toolId !== exp[i].toolId || got[i].source !== exp[i].source) {
      return {
        ok: false,
        reason: `ferramenta ${got[i]?.toolId}≠${exp[i].toolId} ou source ${got[i]?.source}≠${exp[i].source}`,
      };
    }
  }
  return { ok: true };
}

export function validateShieldMaster(doc) {
  const hasFeat = doc.feats?.some((f) => f.featId === "shield-master" && f.source === "general");
  if (!hasFeat) return { ok: true };

  const training = effectiveArmorTrainingWithFeats(doc);
  if (!training.shields) {
    return { ok: false, reason: "shield-master sem treinamento com escudo" };
  }

  const shieldEquipped = doc.equipment?.some((e) => e.equipped && e.slot === "shield");
  if (!shieldEquipped) {
    return { ok: false, reason: "shield-master exige escudo equipado" };
  }
  return { ok: true };
}

export function validateFeatSkillChoices(doc) {
  const proficient = proficientSkillIds(doc);

  for (const feat of doc.feats ?? []) {
    if (feat.source !== "general") continue;

    const skillCfg = FEAT_SKILL_OR_EXPERTISE[feat.featId];
    if (skillCfg) {
      const skillId = feat.featSkillChoice?.skillId;
      if (!skillId || !skillCfg.pool.includes(skillId)) {
        return { ok: false, reason: `${feat.featId} featSkillChoice inválido` };
      }
      if (!proficient.has(skillId)) {
        return { ok: false, reason: `${feat.featId} perícia ${skillId} não proficiente` };
      }
    }

    if (feat.featId === "skill-expert") {
      const { proficiencySkillId, expertiseSkillId } = feat.skillExpert ?? {};
      if (!proficiencySkillId || !expertiseSkillId) {
        return { ok: false, reason: "skill-expert sem skillExpert" };
      }
      if (!proficient.has(proficiencySkillId)) {
        return { ok: false, reason: `skill-expert proficiência ${proficiencySkillId} ausente` };
      }
      if (!proficient.has(expertiseSkillId)) {
        return { ok: false, reason: `skill-expert expertise ${expertiseSkillId} sem proficiência` };
      }
      if (!(doc.expertise ?? []).includes(expertiseSkillId)) {
        return { ok: false, reason: `skill-expert expertise ${expertiseSkillId} não em expertise` };
      }
    }
  }
  return { ok: true };
}
