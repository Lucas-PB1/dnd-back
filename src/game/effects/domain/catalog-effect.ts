import type {
  EffectKind,
  EffectOwnerKind,
  EffectTrigger,
} from '@entities/phb-effect.entity';
import type {
  EffectCastEconomyKind,
  EffectUsesFormula,
} from '@entities/phb-effect-cast-economy.entity';
import type { EffectAmountFormula } from '@entities/phb-effect-numeric.entity';

export type {
  EffectKind,
  EffectOwnerKind,
  EffectTrigger,
  EffectCastEconomyKind,
  EffectUsesFormula,
  EffectAmountFormula,
};

export type EffectSpellSatellite = {
  spellId: string | null;
  spellSlug: string | null;
  optionKey: string | null;
  spellLevel: number | null;
};

export type EffectCastEconomySatellite = {
  economy: EffectCastEconomyKind;
  usesFormula: EffectUsesFormula;
  fixedUses: number | null;
};

export type EffectNumericSatellite = {
  amountFormula: EffectAmountFormula;
  flat: number | null;
};

export type EffectNoteSatellite = {
  note: string;
};

export type EffectResourceSatellite = {
  resourceId: string;
  maxFormula: string;
  fixedMax: number | null;
  recoverOneOnShort: boolean;
  recoverAllOnShort: boolean;
  recoverAllOnLong: boolean;
  recoverOnLongDice: string | null;
};

export type EffectCombatModSatellite = {
  modKind: 'hp_bonus' | 'unarmored_defense';
  flatBonus: number;
  perLevelBonus: number;
  fromLevel: number;
  secondAbilitySlug: string | null;
  allowsShield: boolean;
};

export type EffectProficiencySatellite = {
  optionKey: string;
  proficiencyKind: 'skill' | 'tool' | 'instrument';
};

export type EffectPurchaseDiscountSatellite = {
  percentOff: number;
  nonMagicOnly: boolean;
  foodDrinkOnly: boolean;
};

export type EffectDamageDieSatellite = {
  appliesTo: 'unarmed' | 'weapon';
  die: string;
};

export type EffectWeaponSatellite = {
  propertySlug: string | null;
  rangeNormalFt: number | null;
  rangeLongFt: number | null;
};

export type EffectFeatSatellite = {
  optionKey: string;
  featCategory: string;
};

export type EffectSaveAdvantageSatellite = {
  conditionSlug: string | null;
  abilitySlugs: string[] | null;
};

export type EffectSenseSatellite = {
  senseSlug: string;
  rangeFt: number;
  durationMinutes: number | null;
};

export type EffectDamageTypeSatellite = {
  damageTypeSlug: string | null;
  optionKey: string | null;
};

export type EffectLanguageSatellite = {
  optionKey: string | null;
  languageSlug: string | null;
  choiceCount: number;
};

export type EffectCheckAdvantageSatellite = {
  skillSlug: string | null;
  circumstanceTag: string | null;
  abilitySlug: string | null;
};

export type EffectReachSatellite = {
  bonusFt: number;
  excludePropertySlugs: string[] | null;
};

export type EffectRestQuirkSatellite = {
  longRestHours: number;
  noSleep: boolean;
  noFoodDrinkAir: boolean;
  magicCannotForceSleep: boolean;
};

export type EffectEnvironmentalImmunitySatellite = {
  hazardSlug: string;
};

export type EffectDiceSatellite = {
  die: string;
  dieAtLevel: string | null;
  atLevel: number | null;
  damageTypeSlug: string | null;
};

export type CatalogEffect = {
  id: string;
  kind: EffectKind;
  ownerKind: EffectOwnerKind;
  ownerId: string;
  ownerSlug: string | null;
  trigger: EffectTrigger;
  unlockLevel: number;
  sortOrder: number;
  minTraitTakes: number;
  actionSlug: string | null;
  resourceSlug: string | null;
  label: string | null;
  requiresOptionKey: string | null;
  requiresOptionValue: string | null;
  spell: EffectSpellSatellite | null;
  castEconomy: EffectCastEconomySatellite | null;
  numeric: EffectNumericSatellite | null;
  note: EffectNoteSatellite | null;
  resource: EffectResourceSatellite | null;
  combatMod: EffectCombatModSatellite | null;
  proficiency: EffectProficiencySatellite | null;
  purchaseDiscount: EffectPurchaseDiscountSatellite | null;
  damageDie: EffectDamageDieSatellite | null;
  weapon: EffectWeaponSatellite | null;
  feat: EffectFeatSatellite | null;
  saveAdvantage: EffectSaveAdvantageSatellite | null;
  sense: EffectSenseSatellite | null;
  damageType: EffectDamageTypeSatellite | null;
  language: EffectLanguageSatellite | null;
  checkAdvantage: EffectCheckAdvantageSatellite | null;
  reach: EffectReachSatellite | null;
  restQuirk: EffectRestQuirkSatellite | null;
  environmentalImmunity: EffectEnvironmentalImmunitySatellite | null;
  condition: { conditionSlug: string | null; pendingKind: string | null } | null;
  save: {
    saveAbility: string;
    dcAbility: string | null;
    dcFormula: string;
  } | null;
  forcedMovement: {
    distanceM: number;
    maxTargetSize: string | null;
  } | null;
  dice: EffectDiceSatellite | null;
};
