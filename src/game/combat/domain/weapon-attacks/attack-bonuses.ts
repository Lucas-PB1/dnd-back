import { ownedStyleOrFeatSlugs, styleOrFeatNumericBonus } from "@game/effects";
import { sacredWeaponAttackBonus } from "../paladin/features";
import { abilityShortLabel } from "./weapon-attack-predicates";
import type { WeaponAttackContext } from "./weapon-attack.types";

export type AbilityPick = { slug: "forca" | "destreza"; mod: number };

export type AttackBonusResult = {
  attackBonus: number;
  attackParts: string[];
};

export type DamageBonusResult = {
  damageBonus: number;
  damageParts: string[];
  omitAbilityDamage: boolean;
  overkillExtraDice: string | null;
  overkillAbilityDamageBonus: number;
  rageBonus: number;
};

export { resolveDamageBonuses } from "./damage-bonuses";

export function resolveAttackBonuses(input: {
  ability: AbilityPick;
  proficient: boolean;
  mode: "melee" | "ranged";
  context: WeaponAttackContext;
  charismaModifier: number;
}): AttackBonusResult {
  const attackParts: string[] = [abilityShortLabel(input.ability.slug)];
  let attackBonus = input.ability.mod;
  const owned = ownedStyleOrFeatSlugs(input.context);

  if (input.proficient) {
    attackBonus += input.context.proficiencyBonus;
    attackParts.push("PB");
  }
  if (input.mode === "ranged") {
    const archery = styleOrFeatNumericBonus({
      effects: input.context.featEffects ?? [],
      ownedSlugs: owned,
      ownerSlug: "archery",
      kind: "attack_bonus",
      proficiencyBonus: input.context.proficiencyBonus,
    });
    if (archery !== 0) {
      attackBonus += archery;
      attackParts.push("Arquearia");
    }
  }

  const itemAttackBonus = input.context.itemAttackBonus ?? 0;
  if (itemAttackBonus !== 0) {
    attackBonus += itemAttackBonus;
    attackParts.push("item");
  }

  const sacred = sacredWeaponAttackBonus({
    sacredWeaponActive: input.context.sacredWeaponActive,
    mode: input.mode,
    charismaModifier: input.charismaModifier,
  });
  if (sacred !== 0) {
    attackBonus += sacred;
    attackParts.push("Arma Sagrada");
  }

  return { attackBonus, attackParts };
}
