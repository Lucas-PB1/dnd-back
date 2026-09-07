import {
  isLight,
  isMeleeCapable,
  isTwoHanded,
} from "../weapon-attacks/weapon-attack-predicates";
import { ownedStyleOrFeatSlugs } from "@game/effects";
import type {
  EquippedWeaponPiece,
  WeaponAttackContext,
  WeaponAttackRole,
} from "../weapon-attacks/weapon-attack.types";

export type DualWieldAnalysis = {
  bonusRole: WeaponAttackRole | null;
  dualWieldNeedsFeat: boolean;
  dualWieldTwoHandedOffHand: boolean;
};

export function analyzeDualWield(
  weapons: EquippedWeaponPiece[],
  context: WeaponAttackContext,
): DualWieldAnalysis {
  const main = weapons.find((w) => w.equipmentSlot === "main_hand");
  const off = weapons.find((w) => w.equipmentSlot === "off_hand");
  if (!main || !off) {
    return {
      bonusRole: null,
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: false,
    };
  }

  if (isTwoHanded(off)) {
    return {
      bonusRole: null,
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: true,
    };
  }

  const mainLight = isLight(main) && isMeleeCapable(main);
  const offLight = isLight(off) && isMeleeCapable(off);
  const offMeleeOk = isMeleeCapable(off) && !isTwoHanded(off);

  if (mainLight && offLight) {
    return {
      bonusRole: "light_bonus",
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: false,
    };
  }

  if (
    mainLight &&
    offMeleeOk &&
    !offLight &&
    ownedStyleOrFeatSlugs(context).includes("dual-wielder")
  ) {
    return {
      bonusRole: "dual_bonus",
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: false,
    };
  }

  if (offMeleeOk && !offLight) {
    return {
      bonusRole: null,
      dualWieldNeedsFeat: true,
      dualWieldTwoHandedOffHand: false,
    };
  }

  return {
    bonusRole: null,
    dualWieldNeedsFeat: false,
    dualWieldTwoHandedOffHand: false,
  };
}
