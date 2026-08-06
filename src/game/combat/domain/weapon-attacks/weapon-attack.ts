export type {
  EquippedWeaponPiece,
  WeaponAttack,
  WeaponAttackContext,
  WeaponAttackRole,
} from './weapon-attack.types';
export {
  abilityMod,
  abilityShortLabel,
  buildModes,
  formatDamageNote,
  formatSigned,
  hasProperty,
  hasStyleOrFeat,
  isAmmunitionWeapon,
  isLight,
  isMeleeCapable,
  isProficient,
  isThrownWeapon,
  isTwoHanded,
  pickAbility,
  qualifiesForDueling,
  qualifiesForGreatWeaponFighting,
  usesVersatileTwoHanded,
} from './weapon-attack-predicates';
export type { DualWieldAnalysis } from '../equipment/dual-wield';
export { analyzeDualWield } from '../equipment/dual-wield';
export {
  computeWeaponAttacks,
  heavyWeaponSlugsForSmallSize,
} from './compute-weapon-attacks';
