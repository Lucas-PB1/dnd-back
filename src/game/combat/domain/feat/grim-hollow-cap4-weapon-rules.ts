import { isGunslingerClass } from "../gunslinger/firearm";
import { hasProperty } from "../weapon-attacks/weapon-attack-predicates";
import type { EquippedWeaponPiece } from "../weapon-attacks/weapon-attack.types";

export const BLACK_POWDER_PISTOL_EXPERT_FEAT = "blackpowder-pistol-expert";
export const SYNDICATE_RESOLUTION_FEAT = "resolutionofthe-syndicate";

const BLACK_POWDER_PISTOL_SLUGS = new Set([
  "blackpowder-pistol",
  "dragon-pistol",
]);

export function isBlackPowderPistolSlug(itemSlug: string): boolean {
  return BLACK_POWDER_PISTOL_SLUGS.has(itemSlug);
}

export function hasBlackPowderPistolExpert(
  featSlugs?: readonly string[],
): boolean {
  return (featSlugs ?? []).includes(BLACK_POWDER_PISTOL_EXPERT_FEAT);
}

export function isBlackPowderPistolPiece(piece: EquippedWeaponPiece): boolean {
  if (BLACK_POWDER_PISTOL_SLUGS.has(piece.itemSlug)) return true;
  return (
    hasProperty(piece, "blackpowder") &&
    !hasProperty(piece, "two-handed") &&
    !hasProperty(piece, "cumbersome")
  );
}

export function ignoresBlackPowderPistolReload(
  piece: EquippedWeaponPiece,
  featSlugs?: readonly string[],
): boolean {
  return (
    hasBlackPowderPistolExpert(featSlugs) && isBlackPowderPistolPiece(piece)
  );
}

export function hasSyndicateQuickStrike(
  featSlugs?: readonly string[],
): boolean {
  return (featSlugs ?? []).includes(SYNDICATE_RESOLUTION_FEAT);
}

export function syndicateQuickStrikeDice(level: number): string {
  if (level >= 16) return "4d4";
  if (level >= 9) return "2d4";
  return "1d4";
}

export function canUseFirearmTableActions(input: {
  classSlug: string;
  featSlugs: readonly string[];
}): boolean {
  return (
    isGunslingerClass(input.classSlug) ||
    hasBlackPowderPistolExpert(input.featSlugs)
  );
}

export function isFirearmTableActionSlug(actionSlug: string): boolean {
  return actionSlug === "reload-firearm" || actionSlug === "fire-chamber";
}
