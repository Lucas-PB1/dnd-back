/**
 * PV por classe (Cap. 2, pp. 46–48) — valor fixo por nível.
 */
export const HP_BY_CLASS = {
  barbarian: { level1Die: 12, fixedPerLevel: 7 },
  ranger: { level1Die: 10, fixedPerLevel: 6 },
  fighter: { level1Die: 10, fixedPerLevel: 6 },
  paladin: { level1Die: 10, fixedPerLevel: 6 },
  bard: { level1Die: 8, fixedPerLevel: 5 },
  warlock: { level1Die: 8, fixedPerLevel: 5 },
  cleric: { level1Die: 8, fixedPerLevel: 5 },
  druid: { level1Die: 8, fixedPerLevel: 5 },
  rogue: { level1Die: 8, fixedPerLevel: 5 },
  monk: { level1Die: 8, fixedPerLevel: 5 },
  sorcerer: { level1Die: 6, fixedPerLevel: 4 },
  wizard: { level1Die: 6, fixedPerLevel: 4 },
};

export function abilityMod(score) {
  return Math.floor((score - 10) / 2);
}

/** PV máximos assumindo valor fixo por nível (não dado rolado). */
export function expectedMaxHp(classId, level, constitutionScore) {
  const data = HP_BY_CLASS[classId];
  if (!data || level < 1) return null;
  const conMod = abilityMod(constitutionScore);
  let max = data.level1Die + conMod;
  for (let i = 2; i <= level; i++) {
    max += Math.max(1, data.fixedPerLevel + conMod);
  }
  return max;
}

/** Bônus de PV por espécie (ex.: Tenacidade Anã = +1 por nível). */
export function speciesHpBonus(speciesId, level) {
  if (speciesId === "dwarf") return level;
  return 0;
}

/** Bônus de PV por talento Vigoroso (2× nível ao obter + 2 por nível depois = 2× nível atual). */
export function toughFeatHpBonus(level, toughFeatCount = 1) {
  return toughFeatCount > 0 ? 2 * level * toughFeatCount : 0;
}

/** PV máximos da ficha incluindo espécie e talentos. */
export function expectedMaxHpForCharacter(doc) {
  const base = expectedMaxHp(doc.classId, doc.level, doc.abilities.constituicao);
  if (base == null) return null;
  const toughCount = doc.feats?.filter((f) => f.featId === "tough").length ?? 0;
  return base + speciesHpBonus(doc.speciesId, doc.level) + toughFeatHpBonus(doc.level, toughCount);
}
