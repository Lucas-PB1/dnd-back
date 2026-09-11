import type { AbilityScores } from "@game/shared/infrastructure/player-character.entity";
import { abilityModifier } from "@game/shared/domain/ability-scores";
import type { CatalogEffect } from "@game/effects";
import { ownedStyleOrFeatSlugs, styleOrFeatNumericBonus } from "@game/effects";
import {
  computeSpeciesArmorPreset,
  type SpeciesArmorPresetRow,
} from "../species/manikin-armor";

export type EquippedArmorPiece = {
  itemSlug: string;
  itemName: string;
  categorySlug: string;
  acBase: number | null;
};

export type UnarmoredDefenseRow = {
  label: string;
  secondAbility: keyof AbilityScores;
  allowsShield: boolean;
};

export type ArmorClassContext = {
  featSlugs?: string[];
  fightingStyleSlugs?: string[];
  featEffects?: readonly CatalogEffect[];
  unarmoredDefenses?: readonly UnarmoredDefenseRow[];
  itemAcBonus?: number;
  itemAcBonusNames?: readonly string[];
  /** Preset de CA de espécie (ex.: Manikin) do catálogo. */
  speciesArmorPreset?: SpeciesArmorPresetRow | null;
};

const BODY_ARMOR = new Set(["light", "medium", "heavy"]);

function defenseAcBonus(context: ArmorClassContext | undefined): number {
  return styleOrFeatNumericBonus({
    effects: context?.featEffects ?? [],
    ownedSlugs: ownedStyleOrFeatSlugs(context ?? {}),
    ownerSlug: "defense",
    kind: "ac_bonus",
    proficiencyBonus: 0,
  });
}

function bodyArmorAc(
  piece: EquippedArmorPiece,
  scores: AbilityScores,
  mediumDexCap: number,
): number {
  const base = piece.acBase ?? 10;
  const dexMod = abilityModifier(scores.destreza);
  switch (piece.categorySlug) {
    case "light":
      return base + dexMod;
    case "medium":
      return base + Math.min(dexMod, mediumDexCap);
    case "heavy":
      return base;
    default:
      return base;
  }
}

function pickBestUnarmoredDefense(
  scores: AbilityScores,
  hasShield: boolean,
  candidates: readonly UnarmoredDefenseRow[],
): { armorClass: number; label: string } | null {
  let best: { armorClass: number; label: string } | null = null;
  for (const candidate of candidates) {
    if (hasShield && !candidate.allowsShield) continue;
    const value =
      10 +
      abilityModifier(scores.destreza) +
      abilityModifier(scores[candidate.secondAbility]);
    if (!best || value > best.armorClass) {
      best = { armorClass: value, label: candidate.label };
    }
  }
  return best;
}

export function computeArmorClassFromEquipment(
  scores: AbilityScores,
  equipped: EquippedArmorPiece[],
  context?: ArmorClassContext,
): { armorClass: number; armorClassNote: string } {
  const bodyArmor = equipped.find((piece) =>
    BODY_ARMOR.has(piece.categorySlug),
  );
  const shield = equipped.find((piece) => piece.categorySlug === "shield");
  const hasShield = Boolean(shield);
  const noteParts: string[] = [];

  let armorClass: number;

  if (bodyArmor) {
    const mediumCap =
      bodyArmor.categorySlug === "medium" &&
      ownedStyleOrFeatSlugs(context ?? {}).includes("medium-armor-master") &&
      scores.destreza >= 16
        ? 3
        : 2;
    armorClass = bodyArmorAc(bodyArmor, scores, mediumCap);
    noteParts.push(bodyArmor.itemName);
    if (mediumCap === 3) {
      noteParts.push("Mestre em Armadura Média");
    }
  } else {
    const speciesPreset = context?.speciesArmorPreset
      ? computeSpeciesArmorPreset(scores, context.speciesArmorPreset)
      : null;
    if (speciesPreset) {
      armorClass = speciesPreset.armorClass;
      noteParts.push(speciesPreset.label);
      const defense = speciesPreset.countsAsWornArmor
        ? defenseAcBonus(context)
        : 0;
      if (defense !== 0) {
        armorClass += defense;
        noteParts.push("Defensivo");
      }
    } else {
      const unarmored = pickBestUnarmoredDefense(
        scores,
        hasShield,
        context?.unarmoredDefenses ?? [],
      );
      if (unarmored) {
        armorClass = unarmored.armorClass;
        noteParts.push(unarmored.label);
      } else {
        armorClass = 10 + abilityModifier(scores.destreza);
        noteParts.push("Sem armadura");
      }
    }
  }

  if (shield) {
    armorClass += 2;
    noteParts.push(shield.itemName);
  }

  if (bodyArmor) {
    const defense = defenseAcBonus(context);
    if (defense !== 0) {
      armorClass += defense;
      noteParts.push("Defensivo");
    }
  }

  const itemAcBonus = context?.itemAcBonus ?? 0;
  if (itemAcBonus !== 0) {
    armorClass += itemAcBonus;
    const itemNames = context?.itemAcBonusNames ?? [];
    if (itemNames.length > 0) {
      noteParts.push(...itemNames);
    } else {
      noteParts.push(`itens ${itemAcBonus > 0 ? "+" : ""}${itemAcBonus}`);
    }
  }

  return {
    armorClass,
    armorClassNote: noteParts.join(" + "),
  };
}

export function computeUnarmoredArmorClass(scores: AbilityScores): number {
  return 10 + abilityModifier(scores.destreza);
}
