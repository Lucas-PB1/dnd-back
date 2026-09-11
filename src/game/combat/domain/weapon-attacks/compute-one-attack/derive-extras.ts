import {
  hasBlackPowderPistolExpert,
  hasSyndicateQuickStrike,
  ignoresBlackPowderPistolReload,
  isBlackPowderPistolPiece,
  syndicateQuickStrikeDice,
} from "../../feat/grim-hollow-cap4-weapon-rules";
import {
  brutalStrikeDice as resolveBrutalStrikeDice,
  divineFuryExtraDice,
  hasDivineFury,
} from "../../barbarian/rage";
import { resolveAttackCritThreshold } from "../../gunslinger/firearm";
import { isPsychicBladeItemSlug } from "../../rogue/psychic-blades";
import { ownedStyleOrFeatSlugs, styleOrFeatHasKind } from "@game/effects";
import {
  hasProperty,
  qualifiesForGreatWeaponFighting,
  usesVersatileTwoHanded,
} from "../weapon-attack-predicates";
import type {
  EquippedWeaponPiece,
  WeaponAttackContext,
  WeaponAttackRole,
} from "../weapon-attack.types";
import type { AbilityPick } from "../attack-bonuses";
import { collectAttackNoteExtras } from "../attack-notes";

export function deriveAttackExtras(input: {
  piece: EquippedWeaponPiece;
  mode: "melee" | "ranged";
  context: WeaponAttackContext;
  equippedWeapons: EquippedWeaponPiece[];
  role: WeaponAttackRole;
  ability: AbilityPick;
  monkMartialArtsDie: string | null;
}) {
  const { piece, mode, context, equippedWeapons, role, ability } = input;
  const versatile2h = usesVersatileTwoHanded(
    piece,
    equippedWeapons,
    Boolean(context.hasShield),
  );
  const isFirearm = hasProperty(piece, "firearm");
  const ignoresReload = ignoresBlackPowderPistolReload(
    piece,
    context.featSlugs,
  );
  const quickStrikeDice = hasSyndicateQuickStrike(context.featSlugs)
    ? syndicateQuickStrikeDice(context.level ?? 1)
    : null;
  const greatWeaponFighting =
    styleOrFeatHasKind({
      effects: context.featEffects ?? [],
      ownedSlugs: ownedStyleOrFeatSlugs(context),
      ownerSlug: "great-weapon-fighting",
      kind: "damage_die_floor",
    }) && qualifiesForGreatWeaponFighting(piece, mode, versatile2h);

  const masterySlug = piece.masterySlug ?? null;
  const masteryName = piece.masteryName ?? null;
  const masteryActive =
    Boolean(masterySlug) &&
    ((context.masteredWeaponSlugs ?? []).includes(piece.itemSlug) ||
      isPsychicBladeItemSlug(piece.itemSlug));
  const nickUsesAttackAction =
    masteryActive &&
    masterySlug === "nick" &&
    (role === "light_bonus" || role === "dual_bonus");
  const grazeOnMissDamage =
    masteryActive && masterySlug === "graze" ? ability.mod : null;
  const attackDisadvantage =
    context.sizeCategory === "small" && hasProperty(piece, "heavy");
  const critThreshold = resolveAttackCritThreshold({
    classSlug: context.classSlug,
    subclassSlug: context.subclassSlug,
    level: context.level,
    mode,
    featureSchedules: context.featureSchedules,
  });
  const brutalDice =
    mode === "melee" && ability.slug === "forca"
      ? resolveBrutalStrikeDice(context.level ?? 0, context.featureSchedules)
      : null;
  const divineFuryDice = hasDivineFury({
    subclassSlug: context.subclassSlug,
    level: context.level,
  })
    ? divineFuryExtraDice(context.level ?? 0)
    : null;

  return {
    isFirearm,
    ignoresReload,
    quickStrikeDice,
    greatWeaponFighting,
    masteryActive,
    masterySlug,
    masteryName,
    nickUsesAttackAction,
    grazeOnMissDamage,
    attackDisadvantage,
    critThreshold,
    brutalDice,
    divineFuryDice,
    noteExtras: collectAttackNoteExtras({
      piece,
      role,
      versatile2h,
      isFirearm,
      ignoresReload,
      deadeyeNoLongRangePenalty:
        mode === "ranged" &&
        hasBlackPowderPistolExpert(context.featSlugs) &&
        isBlackPowderPistolPiece(piece),
      greatWeaponFighting,
      masteryActive,
      masterySlug,
      masteryName,
      nickUsesAttackAction,
      attackDisadvantage,
      critThreshold,
      brutalDice,
      monkMartialArtsDie: input.monkMartialArtsDie,
    }),
  };
}
