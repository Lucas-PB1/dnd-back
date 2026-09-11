import { martialArtsDie, martialArtsDieFaces } from "../../monk/features";
import { usesVersatileTwoHanded } from "../weapon-attack-predicates";
import type {
  EquippedWeaponPiece,
  WeaponAttackContext,
} from "../weapon-attack.types";

const UNARMED_SLUG = "unarmed-strike";

export function resolveDamageDice(input: {
  piece: EquippedWeaponPiece;
  equippedWeapons: EquippedWeaponPiece[];
  context: WeaponAttackContext;
  monkEligible: boolean;
}): { damageDice: string; monkMartialArtsDie: string | null } {
  const versatile2h = usesVersatileTwoHanded(
    input.piece,
    input.equippedWeapons,
    Boolean(input.context.hasShield),
  );
  let damageDice = versatile2h
    ? (input.piece.versatileDamage ?? input.piece.damage ?? "1")
    : (input.piece.damage ?? "1");

  if (input.piece.itemSlug === UNARMED_SLUG && input.context.unarmedDamageDie) {
    damageDice = input.context.unarmedDamageDie;
  }

  let monkMartialArtsDie: string | null = null;
  if (input.monkEligible) {
    const schedules = input.context.featureSchedules;
    const maFaces = martialArtsDieFaces(input.context.level ?? 1, schedules);
    const weaponFaces = Number(/d(\d+)/i.exec(damageDice)?.[1] ?? "0");
    if (maFaces > weaponFaces) {
      damageDice = martialArtsDie(input.context.level ?? 1, schedules);
    }
    monkMartialArtsDie = martialArtsDie(input.context.level ?? 1, schedules);
  }
  return { damageDice, monkMartialArtsDie };
}
