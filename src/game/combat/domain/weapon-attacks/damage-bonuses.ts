import type { AbilityScores } from "@game/shared/infrastructure/player-character.entity";
import {
  ownedStyleOrFeatSlugs,
  styleOrFeatHasKind,
  styleOrFeatNumericBonus,
} from "@game/effects";
import { appliesRageDamageBonus } from "../barbarian/rage";
import { applyOverkillDamageBonus } from "../gunslinger/firearm";
import {
  abilityShortLabel,
  hasProperty,
  isThrownWeapon,
  qualifiesForDueling,
} from "./weapon-attack-predicates";
import type {
  EquippedWeaponPiece,
  WeaponAttackContext,
  WeaponAttackRole,
} from "./weapon-attack.types";
import type {
  AbilityPick,
  DamageBonusResult,
} from "./attack-bonuses";

export function resolveDamageBonuses(input: {
  scores: AbilityScores;
  ability: AbilityPick;
  piece: EquippedWeaponPiece;
  mode: "melee" | "ranged";
  context: WeaponAttackContext;
  equippedWeapons: EquippedWeaponPiece[];
  role: WeaponAttackRole;
}): DamageBonusResult {
  const owned = ownedStyleOrFeatSlugs(input.context);
  const isBonusAttack =
    input.role === "light_bonus" || input.role === "dual_bonus";
  const hasTwf = styleOrFeatHasKind({
    effects: input.context.featEffects ?? [],
    ownedSlugs: owned,
    ownerSlug: "two-weapon-fighting",
    kind: "light_bonus_ability_mod",
  });
  const omitAbilityDamage = isBonusAttack && !hasTwf && input.ability.mod >= 0;
  const isFirearm = hasProperty(input.piece, "firearm");
  const overkill =
    input.mode === "ranged"
      ? applyOverkillDamageBonus({
          level: input.context.level ?? 1,
          isFirearm,
          abilityMod: input.ability.mod,
        })
      : {
          abilityDamageBonus: input.ability.mod,
          extraDamageDice: null as string | null,
        };

  let damageBonus = 0;
  const damageParts: string[] = [];

  if (omitAbilityDamage) {
    if (input.ability.mod < 0) {
      damageBonus = input.ability.mod;
      damageParts.push(abilityShortLabel(input.ability.slug));
    }
  } else if (isFirearm && input.mode === "ranged") {
    damageBonus = overkill.abilityDamageBonus;
    if (damageBonus !== 0) {
      damageParts.push(abilityShortLabel(input.ability.slug));
      if ((input.context.level ?? 1) >= 11) damageParts.push("Exagero");
    } else {
      damageParts.push("arma de fogo");
    }
  } else {
    damageBonus = overkill.abilityDamageBonus;
    damageParts.push(abilityShortLabel(input.ability.slug));
    if (overkill.extraDamageDice) damageParts.push("Exagero");
  }

  if (qualifiesForDueling(input.piece, input.mode, input.equippedWeapons)) {
    const dueling = styleOrFeatNumericBonus({
      effects: input.context.featEffects ?? [],
      ownedSlugs: owned,
      ownerSlug: "dueling",
      kind: "damage_bonus",
      proficiencyBonus: input.context.proficiencyBonus,
    });
    if (dueling !== 0) {
      damageBonus += dueling;
      damageParts.push("Duelismo");
    }
  }
  if (input.mode === "ranged" && isThrownWeapon(input.piece)) {
    const thrown = styleOrFeatNumericBonus({
      effects: input.context.featEffects ?? [],
      ownedSlugs: owned,
      ownerSlug: "thrown-weapon-fighting",
      kind: "damage_bonus",
      proficiencyBonus: input.context.proficiencyBonus,
    });
    if (thrown !== 0) {
      damageBonus += thrown;
      damageParts.push("Arremesso");
    }
  }
  if (hasProperty(input.piece, "heavy")) {
    const gwm = styleOrFeatNumericBonus({
      effects: input.context.featEffects ?? [],
      ownedSlugs: owned,
      ownerSlug: "great-weapon-master",
      kind: "damage_bonus",
      proficiencyBonus: input.context.proficiencyBonus,
    });
    if (gwm !== 0) {
      damageBonus += gwm;
      damageParts.push("Mestre em Armas Grandes");
    }
  }

  const rageBonus = appliesRageDamageBonus({
    classSlug: input.context.classSlug,
    level: input.context.level,
    rageActive: input.context.rageActive,
    mode: input.mode,
    abilitySlug: input.ability.slug,
  });
  if (rageBonus > 0) {
    damageBonus += rageBonus;
    damageParts.push(`Fúria +${rageBonus}`);
  }

  const itemDamageBonus = input.context.itemDamageBonus ?? 0;
  if (itemDamageBonus !== 0) {
    damageBonus += itemDamageBonus;
    damageParts.push("item");
  }

  const overkillExtraDice =
    input.mode === "ranged" && !isFirearm && !omitAbilityDamage
      ? overkill.extraDamageDice
      : null;

  return {
    damageBonus,
    damageParts,
    omitAbilityDamage,
    overkillExtraDice,
    overkillAbilityDamageBonus: overkill.abilityDamageBonus,
    rageBonus,
  };
}
