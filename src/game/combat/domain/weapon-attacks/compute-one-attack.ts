import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { brutalStrikeDice as resolveBrutalStrikeDice } from '../barbarian/rage';
import { resolveAttackCritThreshold } from '../gunslinger/firearm';
import {
  MONK_UNARMED_ITEM_SLUG,
  isMonkClass,
  isMonkWeaponForAttack,
  martialArtsDie,
  martialArtsDieFaces,
} from '../monk/features';
import {
  abilityMod,
  hasProperty,
  hasStyleOrFeat,
  isProficient,
  pickAbility,
  qualifiesForGreatWeaponFighting,
  usesVersatileTwoHanded,
} from './weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
  WeaponAttackContext,
  WeaponAttackRole,
} from './weapon-attack.types';
import {
  resolveAttackBonuses,
  resolveDamageBonuses,
  type AbilityPick,
} from './attack-bonuses';
import { assembleWeaponAttack } from './assemble-attack';
import { collectAttackNoteExtras } from './attack-notes';

function resolveMonkAbility(
  scores: AbilityScores,
  ability: AbilityPick,
): AbilityPick {
  const str = abilityMod(scores.forca);
  const dex = abilityMod(scores.destreza);
  if (dex > ability.mod) return { slug: 'destreza', mod: dex };
  if (str >= dex && str > ability.mod) return { slug: 'forca', mod: str };
  return ability;
}

function resolveDamageDice(input: {
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
    ? (input.piece.versatileDamage ?? input.piece.damage ?? '1')
    : (input.piece.damage ?? '1');
  let monkMartialArtsDie: string | null = null;
  if (input.monkEligible) {
    const maFaces = martialArtsDieFaces(input.context.level ?? 1);
    const weaponFaces = Number(/d(\d+)/i.exec(damageDice)?.[1] ?? '0');
    if (maFaces > weaponFaces) {
      damageDice = martialArtsDie(input.context.level ?? 1);
    }
    monkMartialArtsDie = martialArtsDie(input.context.level ?? 1);
  }
  return { damageDice, monkMartialArtsDie };
}

export function computeOneAttack(
  scores: AbilityScores,
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  context: WeaponAttackContext,
  equippedWeapons: EquippedWeaponPiece[],
  role: WeaponAttackRole,
): WeaponAttack {
  const monkEligible =
    isMonkClass(context.classSlug) &&
    !context.hasShield &&
    isMonkWeaponForAttack(piece, mode);
  const proficient =
    piece.itemSlug === MONK_UNARMED_ITEM_SLUG
      ? true
      : isProficient(piece, context);
  let ability = pickAbility(scores, piece, mode);
  if (monkEligible) ability = resolveMonkAbility(scores, ability);

  const { attackBonus, attackParts } = resolveAttackBonuses({
    ability,
    proficient,
    mode,
    context,
  });
  const damage = resolveDamageBonuses({
    scores,
    ability,
    piece,
    mode,
    context,
    equippedWeapons,
    role,
  });

  const versatile2h = usesVersatileTwoHanded(
    piece,
    equippedWeapons,
    Boolean(context.hasShield),
  );
  const { damageDice, monkMartialArtsDie } = resolveDamageDice({
    piece,
    equippedWeapons,
    context,
    monkEligible,
  });
  const isFirearm = hasProperty(piece, 'firearm');
  const greatWeaponFighting =
    hasStyleOrFeat(context, 'great-weapon-fighting') &&
    qualifiesForGreatWeaponFighting(piece, mode, versatile2h);

  const masterySlug = piece.masterySlug ?? null;
  const masteryName = piece.masteryName ?? null;
  const masteryActive =
    Boolean(masterySlug) &&
    (context.masteredWeaponSlugs ?? []).includes(piece.itemSlug);
  const nickUsesAttackAction =
    masteryActive &&
    masterySlug === 'nick' &&
    (role === 'light_bonus' || role === 'dual_bonus');
  const grazeOnMissDamage =
    masteryActive && masterySlug === 'graze' ? ability.mod : null;
  const attackDisadvantage =
    context.sizeCategory === 'small' && hasProperty(piece, 'heavy');
  const critThreshold = resolveAttackCritThreshold({
    classSlug: context.classSlug,
    subclassSlug: context.subclassSlug,
    level: context.level,
    mode,
  });
  const brutalDice =
    mode === 'melee' && ability.slug === 'forca'
      ? resolveBrutalStrikeDice(context.level ?? 0)
      : null;

  return assembleWeaponAttack({
    piece,
    mode,
    ability,
    proficient,
    attackBonus,
    attackParts,
    damageBonus: damage.damageBonus,
    damageParts: damage.damageParts,
    omitAbilityDamage: damage.omitAbilityDamage,
    overkillExtraDice: damage.overkillExtraDice,
    overkillAbilityDamageBonus: damage.overkillAbilityDamageBonus,
    rageBonus: damage.rageBonus,
    damageDice,
    monkMartialArtsDie,
    role,
    isFirearm,
    greatWeaponFighting,
    masteryActive,
    masterySlug,
    masteryName,
    nickUsesAttackAction,
    grazeOnMissDamage,
    attackDisadvantage,
    critThreshold,
    brutalDice,
    noteExtras: collectAttackNoteExtras({
      piece,
      role,
      versatile2h,
      isFirearm,
      greatWeaponFighting,
      masteryActive,
      masterySlug,
      masteryName,
      nickUsesAttackAction,
      attackDisadvantage,
      critThreshold,
      brutalDice,
      monkMartialArtsDie,
    }),
  });
}
