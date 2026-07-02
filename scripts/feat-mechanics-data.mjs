/**
 * Talentos com mecânica aplicada no gerador/validador (PHB 2024).
 * Demais feats existem só no catálogo (benefícios textuais).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { EPIC_BOON_IDS } from "./class-feat-progression-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "data/phb");

export const MAGIC_INITIATE_BACKGROUND_CLASS = {
  acolyte: "cleric",
  guide: "druid",
  sage: "wizard",
};

/** Hooks mecânicos por talento implementado. */
export const FEAT_MECHANICS = {
  "ability-score-improvement": {
    hooks: ["asi", "class_progression"],
    description: "ASI de classe (+2 ou +1/+1, máx 20)",
  },
  "magic-initiate": {
    hooks: ["spells", "feat_options"],
    description: "2 truques + 1 magia 1º círculo (lista por antecedente)",
  },
  skilled: {
    hooks: ["skills"],
    skillsPerInstance: 3,
    description: "3 perícias com source feat por instância",
  },
  tough: {
    hooks: ["hp"],
    description: "+2 PV por nível",
  },
  "weapon-master": {
    hooks: ["asi", "weapon_mastery", "general_progression"],
    description: "+1 slot de maestria em armas",
  },
  observant: {
    hooks: ["asi", "expertise", "general_progression", "passive", "skills"],
    description: "ASI Int/Sab + perícia ou especialização",
  },
  "keen-mind": {
    hooks: ["asi", "expertise", "general_progression", "passive", "skills"],
    description: "ASI Int + perícia Int/Sab ou especialização",
  },
  "skill-expert": {
    hooks: ["asi", "expertise", "skills", "general_progression"],
    description: "ASI + proficiência + especialização",
  },
  "boon-of-skill-proficiency": { hooks: ["expertise", "asi"], description: "+1 especialização + ASI épico" },
  "boon-of-fortitude": {
    hooks: ["asi", "hp"],
    hpBonus: 40,
    description: "+40 PV máx + ASI épico",
  },
  "fey-touched": { hooks: ["asi", "spells", "general_progression"], description: "ASI Int/Sab/Car + magias feéricas" },
  "shadow-touched": { hooks: ["asi", "spells", "general_progression"], description: "ASI Int/Sab/Car + magias sombrias" },
  resilient: { hooks: ["asi", "saving_throw", "general_progression"], description: "ASI + proficiência em salvaguarda" },
  "lightly-armored": { hooks: ["asi", "armor_training", "general_progression"], description: "ASI For/Des + armadura leve" },
  "moderately-armored": { hooks: ["asi", "armor_training", "general_progression"], description: "ASI For/Des + armadura média" },
  "heavily-armored": { hooks: ["asi", "armor_training", "general_progression"], description: "ASI Con/For + armadura pesada" },
  "martial-weapon-training": {
    hooks: ["asi", "weapon_proficiency", "general_progression"],
    description: "ASI For/Des + armas marciais",
  },
  telekinetic: { hooks: ["asi", "spells", "general_progression"], description: "ASI Int/Sab/Car + Mãos Mágicas" },
  telepathic: { hooks: ["asi", "spells", "general_progression"], description: "ASI Int/Sab/Car + Detectar Pensamentos" },
  durable: { hooks: ["asi", "general_progression"], description: "ASI Con + Desafie a Morte" },
  athlete: { hooks: ["asi", "general_progression"], description: "ASI For/Des + mobilidade" },
  "medium-armor-master": { hooks: ["asi", "armor_training", "general_progression"], description: "ASI + Dex 16→+3 CA média" },
  "heavy-armor-master": { hooks: ["asi", "armor_training", "general_progression"], description: "ASI + redução de dano pesada" },
  "ritual-caster": { hooks: ["asi", "spells", "general_progression"], description: "ASI + magias rituais (PB)" },
  "war-caster": { hooks: ["asi", "general_progression"], description: "ASI + Concentração/Magia Reativa" },
  "elemental-adept": { hooks: ["asi", "general_progression", "passive"], description: "ASI + domínio elemental" },
  "great-weapon-master": { hooks: ["asi", "general_progression", "passive"], description: "ASI For + armas pesadas" },
  sharpshooter: { hooks: ["asi", "general_progression", "passive"], description: "ASI Des + tiro à distância" },
  sentinel: { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + ataques de oportunidade" },
  "polearm-master": { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + haste com armas" },
  mobile: { hooks: ["asi", "general_progression", "passive"], description: "ASI Des/Con + deslocamento" },
  "shield-master": { hooks: ["asi", "general_progression", "passive", "equipment"], description: "ASI For + escudo" },
  grappler: { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + agarrar" },
  "dual-wielder": { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + duas armas" },
  "crossbow-expert": { hooks: ["asi", "general_progression", "passive"], description: "ASI Des + besta" },
  crusher: { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Con + contundente" },
  piercer: { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + perfurante" },
  slasher: { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + cortante" },
  stealthy: { hooks: ["asi", "general_progression", "passive"], description: "ASI Des + furtividade" },
  "spell-sniper": { hooks: ["asi", "general_progression", "passive"], description: "ASI Int/Sab/Car + alcance de magias" },
  "mage-slayer": { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + anti-magia" },
  "defensive-duelist": { hooks: ["asi", "general_progression", "passive"], description: "ASI Des + parry" },
  charger: { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des + investida" },
  "mounted-combatant": { hooks: ["asi", "general_progression", "passive"], description: "ASI For/Des/Sab + montaria" },
  poisoner: { hooks: ["asi", "general_progression", "passive", "tools"], description: "ASI Des/Int + veneno" },
  actor: { hooks: ["asi", "general_progression", "passive", "tools"], description: "ASI Car + disfarce" },
  chef: { hooks: ["asi", "general_progression", "passive", "tools"], description: "ASI Con/Sab + cozinha" },
  "inspiring-leader": { hooks: ["asi", "general_progression", "passive"], description: "ASI Sab/Car + discurso" },
  alert: { hooks: ["passive"], description: "Iniciativa + troca de surpresa" },
  artisan: { hooks: ["tools"], description: "Ferramentas + desconto em crafting" },
  healer: { hooks: ["passive", "tools"], description: "Kit + cura por dado de vida" },
  lucky: { hooks: ["passive"], description: "Pontos de sorte" },
  musician: { hooks: ["passive"], description: "Instrumentos + inspiração" },
  "savage-attacker": { hooks: ["passive"], description: "Rerrolar dano de arma" },
  "tavern-brawler": { hooks: ["passive"], description: "Improvisado + agarrar" },
};

for (const id of EPIC_BOON_IDS) {
  if (!FEAT_MECHANICS[id]) {
    FEAT_MECHANICS[id] = { hooks: ["asi", "class_progression"], description: "Dádiva épica (+1 atributo, máx 30)" };
  }
}

/** Estilos de luta são feats no PHB, mas ficam em classChoices.fightingStyleId. */
const FIGHTING_STYLES_DOC = JSON.parse(
  fs.readFileSync(path.join(phb, "classes/fighting-styles.json"), "utf8")
);
export const FIGHTING_STYLE_FEAT_IDS = [
  ...FIGHTING_STYLES_DOC.standardStyleIds,
  ...Object.values(FIGHTING_STYLES_DOC.classAlternativeStyleIds ?? {}).flat(),
];

export function allPhbFeatIds() {
  const index = JSON.parse(fs.readFileSync(path.join(phb, "feats/index.json"), "utf8"));
  return index.feats.map((f) => f.id);
}

export function implementedFeatIds() {
  return [...new Set([...Object.keys(FEAT_MECHANICS), ...FIGHTING_STYLE_FEAT_IDS])];
}

export function catalogOnlyFeatIds() {
  const impl = new Set(implementedFeatIds());
  return allPhbFeatIds().filter((id) => !impl.has(id));
}
