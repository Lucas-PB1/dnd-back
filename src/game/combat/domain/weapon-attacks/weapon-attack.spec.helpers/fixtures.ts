import type { CatalogEffect } from "@game/effects";
import type { AbilityScores } from "@game/shared/infrastructure/player-character.entity";
import { fixtureSchedulesFor } from "../../feature-schedule.fixtures";
import type { EquippedWeaponPiece } from "../weapon-attack";
import type { WeaponAttackContext } from "../weapon-attack.types";

export function testScores(
  partial: Partial<AbilityScores> = {},
): AbilityScores {
  return {
    forca: 16,
    destreza: 14,
    constituicao: 13,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
    ...partial,
  };
}

function styleEffect(
  slug: string,
  kind: CatalogEffect["kind"],
  numeric: CatalogEffect["numeric"] = null,
): CatalogEffect {
  return {
    id: slug,
    kind,
    ownerKind: "feat",
    ownerId: "1",
    ownerSlug: slug,
    trigger: "passive",
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    label: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric,
    note: null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
  };
}

/** Efeitos tipados para estilos/talentos usados nos specs de ataque (sem legacyFlat). */
export function catalogEffectsForOwnedStyles(
  owned: readonly string[],
): CatalogEffect[] {
  const effects: CatalogEffect[] = [];
  for (const slug of owned) {
    switch (slug) {
      case "archery":
        effects.push(
          styleEffect("archery", "attack_bonus", {
            amountFormula: "fixed",
            flat: 2,
          }),
        );
        break;
      case "defense":
        effects.push(
          styleEffect("defense", "ac_bonus", {
            amountFormula: "fixed",
            flat: 1,
          }),
        );
        break;
      case "dueling":
      case "thrown-weapon-fighting":
        effects.push(
          styleEffect(slug, "damage_bonus", {
            amountFormula: "fixed",
            flat: 2,
          }),
        );
        break;
      case "two-weapon-fighting":
        effects.push(styleEffect(slug, "light_bonus_ability_mod"));
        break;
      case "great-weapon-fighting":
        effects.push(styleEffect(slug, "damage_die_floor"));
        break;
      case "great-weapon-master":
        effects.push(
          styleEffect(slug, "damage_bonus", {
            amountFormula: "proficiency_bonus",
            flat: null,
          }),
        );
        break;
      default:
        break;
    }
  }
  return effects;
}

export function withOwnedStyleEffects(
  ctx: WeaponAttackContext,
): WeaponAttackContext {
  const owned = [
    ...(ctx.featSlugs ?? []),
    ...(ctx.fightingStyleSlugs ?? []),
  ];
  return {
    ...ctx,
    featEffects: [
      ...(ctx.featEffects ?? []),
      ...catalogEffectsForOwnedStyles(owned),
    ],
  };
}

export const FIGHTER_CTX: WeaponAttackContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ["armas-simples", "armas-marciais"],
  featureSchedules: fixtureSchedulesFor('fighter'),
};

export const GUNSLINGER_RANGED_CTX: WeaponAttackContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ["armas-simples", "armas-marciais-a-distancia"],
  featureSchedules: fixtureSchedulesFor('gunslinger'),
};

export function longsword(
  slot: EquippedWeaponPiece["equipmentSlot"] = "main_hand",
): EquippedWeaponPiece {
  return {
    itemSlug: "longsword",
    itemName: "Espada Longa",
    category: "martial",
    damage: "1d8",
    damageType: "Cortante",
    versatileDamage: "1d10",
    propertySlugs: ["versatile"],
    equipmentSlot: slot,
  };
}

export function longbow(): EquippedWeaponPiece {
  return {
    itemSlug: "longbow",
    itemName: "Arco Longo",
    category: "martial",
    damage: "1d8",
    damageType: "Perfurante",
    versatileDamage: null,
    propertySlugs: ["two-handed", "ammunition", "heavy"],
    equipmentSlot: "main_hand",
  };
}

export function dagger(
  slot: EquippedWeaponPiece["equipmentSlot"] = "main_hand",
): EquippedWeaponPiece {
  return {
    itemSlug: "dagger",
    itemName: "Adaga",
    category: "simple",
    damage: "1d4",
    damageType: "Perfurante",
    versatileDamage: null,
    propertySlugs: ["finesse", "thrown", "light"],
    equipmentSlot: slot,
  };
}

export function shortsword(
  slot: EquippedWeaponPiece["equipmentSlot"] = "off_hand",
): EquippedWeaponPiece {
  return {
    itemSlug: "shortsword",
    itemName: "Espada Curta",
    category: "martial",
    damage: "1d6",
    damageType: "Perfurante",
    versatileDamage: null,
    propertySlugs: ["finesse", "light"],
    equipmentSlot: slot,
  };
}

export function greataxe(): EquippedWeaponPiece {
  return {
    itemSlug: "greataxe",
    itemName: "Machado Grande",
    category: "martial",
    damage: "1d12",
    damageType: "Cortante",
    versatileDamage: null,
    propertySlugs: ["two-handed", "heavy"],
    equipmentSlot: "main_hand",
  };
}

export function catchpole(): EquippedWeaponPiece {
  return {
    itemSlug: "catchpole",
    itemName: "Catchpole",
    category: "advanced",
    damage: "1d6",
    damageType: "Perfurante",
    propertySlugs: ["hafted", "reach", "two-handed"],
    equipmentSlot: "main_hand",
    versatileDamage: null,
  };
}

export function revolver(): EquippedWeaponPiece {
  return {
    itemSlug: "revolver",
    itemName: "Revólver",
    category: "martial",
    damage: "2d8",
    damageType: "Perfurante",
    versatileDamage: null,
    propertySlugs: ["ammunition", "firearm", "reload"],
    equipmentSlot: "main_hand",
    reloadCapacity: 6,
  };
}

export function blackpowderPistol(): EquippedWeaponPiece {
  return {
    itemSlug: "blackpowder-pistol",
    itemName: "Pistola de Pólvora",
    category: "advanced",
    damage: "2d4",
    damageType: "Perfurante",
    versatileDamage: null,
    propertySlugs: [
      "blackpowder",
      "light",
      "loading",
      "ammunition",
      "firearm",
      "reload",
    ],
    equipmentSlot: "main_hand",
    reloadCapacity: 1,
  };
}

export function greatswordGraze(): EquippedWeaponPiece {
  return {
    itemSlug: "greatsword",
    itemName: "Espada Grande",
    category: "martial",
    damage: "2d6",
    damageType: "Cortante",
    versatileDamage: null,
    propertySlugs: ["two-handed", "heavy"],
    equipmentSlot: "main_hand",
    masterySlug: "graze",
    masteryName: "Resvalar",
  };
}

export const SOULKNIFE_PSYCHIC_BLADES: EquippedWeaponPiece[] = [
  {
    itemSlug: "psychic-blade",
    itemName: "Lâmina Psíquica",
    category: "simple",
    damage: "1d6",
    damageType: "Psíquico",
    versatileDamage: null,
    propertySlugs: ["finesse", "thrown"],
    equipmentSlot: "main_hand",
    masterySlug: "vex",
    masteryName: "Afligir",
  },
  {
    itemSlug: "psychic-blade-bonus",
    itemName: "Lâmina Psíquica (adicional)",
    category: "simple",
    damage: "1d4",
    damageType: "Psíquico",
    versatileDamage: null,
    propertySlugs: ["finesse", "thrown", "light"],
    equipmentSlot: "off_hand",
    masterySlug: "vex",
    masteryName: "Afligir",
  },
];
