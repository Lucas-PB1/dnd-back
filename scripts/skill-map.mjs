/**
 * Mapas estáveis de perícias e atributos (PT → id).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

const skillsIndex = JSON.parse(
  fs.readFileSync(path.join(root, "data/phb/skills/index.json"), "utf8")
);

export const SKILL_NAME_TO_ID = Object.fromEntries(
  skillsIndex.skills.map((s) => [s.name, s.id])
);

export const SKILL_ID_TO_NAME = Object.fromEntries(
  skillsIndex.skills.map((s) => [s.id, s.name])
);

export const ABILITY_NAME_TO_ID = Object.fromEntries(
  skillsIndex.abilities.map((a) => [a.name, a.id])
);

export const ABILITY_ID_TO_NAME = Object.fromEntries(
  skillsIndex.abilities.map((a) => [a.id, a.name])
);

export function toSkillId(name) {
  const id = SKILL_NAME_TO_ID[name];
  if (!id) throw new Error(`Perícia desconhecida: ${name}`);
  return id;
}

export function toAbilityId(name) {
  const id = ABILITY_NAME_TO_ID[name];
  if (!id) throw new Error(`Atributo desconhecido: ${name}`);
  return id;
}
