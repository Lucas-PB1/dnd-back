/**
 * Catálogos de escolha em traços de espécie — extraídos do JSON PHB.
 */
import {
  ELF_LINEAGE_SPELLS,
  TIEFLING_LEGACY_SPELLS,
} from "../character-rules.mjs";

const CHOICE_KIND = {
  elf: { "Linhagem Élfica": "elf_lineage" },
  tiefling: { "Legado Ínfero": "infernal_legacy" },
  dragonborn: { "Herança Dracônica": "dragon_ancestry" },
};

export function choiceKindForTrait(speciesId, traitName) {
  return CHOICE_KIND[speciesId]?.[traitName] ?? null;
}

export function buildSpeciesTraitCatalogs(speciesList) {
  const elfLineages = [];
  const infernalLegacies = [];
  const dragonAncestries = [];

  for (const sp of speciesList) {
    for (const trait of sp.traits ?? []) {
      if (!trait.table?.rows) continue;
      for (const row of trait.table.rows) {
        if (sp.id === "elf") {
          const spells = ELF_LINEAGE_SPELLS[row.id] ?? {};
          elfLineages.push({
            slug: row.id,
            name: row.legacy,
            level1Benefit: row.level1,
            spellLevel3Slug: spells[3]?.[0] ?? null,
            spellLevel5Slug: spells[5]?.[0] ?? null,
          });
        } else if (sp.id === "tiefling") {
          const spells = TIEFLING_LEGACY_SPELLS[row.id] ?? {};
          infernalLegacies.push({
            slug: row.id,
            name: row.legacy,
            level1Benefit: row.level1,
            spellLevel3Slug: spells[3]?.[0] ?? null,
            spellLevel5Slug: spells[5]?.[0] ?? null,
          });
        } else if (sp.id === "dragonborn") {
          dragonAncestries.push({
            slug: row.id,
            name: row.legacy,
            damageType: row.level1,
          });
        }
      }
    }
  }

  return { elfLineages, infernalLegacies, dragonAncestries };
}
