import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  MONK_UNARMED_ITEM_SLUG,
  isMonkClass,
  isMonkWeaponForAttack,
} from '../../monk/features';
import { isPsychicBladeItemSlug } from '../../rogue/psychic-blades';
import { isProficient, pickAbility } from '../weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
  WeaponAttackContext,
  WeaponAttackRole,
} from '../weapon-attack.types';
import { resolveAttackBonuses, resolveDamageBonuses } from '../attack-bonuses';
import { assembleWeaponAttack } from '../assemble-attack';
import { resolveDamageDice } from './damage-dice';
import { deriveAttackExtras } from './derive-extras';
import { resolveMonkAbility } from './monk-ability';

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
    piece.itemSlug === MONK_UNARMED_ITEM_SLUG ||
    isPsychicBladeItemSlug(piece.itemSlug)
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
  const { damageDice, monkMartialArtsDie } = resolveDamageDice({
    piece,
    equippedWeapons,
    context,
    monkEligible,
  });
  const extras = deriveAttackExtras({
    piece,
    mode,
    context,
    equippedWeapons,
    role,
    ability,
    monkMartialArtsDie,
  });

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
    ...extras,
  });
}
