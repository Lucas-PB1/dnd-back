import type { PhbEffect } from '@entities/effect/phb-effect.entity';
import type { CatalogEffect } from '../domain/catalog-effect';

export function mapPhbEffectToCatalog(
  row: PhbEffect,
  ownerSlug: string | null,
): CatalogEffect {
  return {
    id: row.id,
    kind: row.kind,
    ownerKind: row.ownerKind,
    ownerId: row.ownerId,
    ownerSlug,
    trigger: row.trigger,
    unlockLevel: row.unlockLevel,
    sortOrder: row.sortOrder,
    minTraitTakes: row.minTraitTakes,
    actionSlug: row.actionSlug,
    resourceSlug: row.resourceSlug,
    label: row.label,
    requiresOptionKey: row.requiresOptionKey,
    requiresOptionValue: row.requiresOptionValue,
    spell: row.spell
      ? {
          spellId: row.spell.spellId,
          spellSlug: row.spell.spellSlug ?? null,
          optionKey: row.spell.optionKey,
          spellLevel: row.spell.spellLevel,
        }
      : null,
    castEconomy: row.castEconomy
      ? {
          economy: row.castEconomy.economy,
          usesFormula: row.castEconomy.usesFormula,
          fixedUses: row.castEconomy.fixedUses,
        }
      : null,
    numeric: row.numeric
      ? {
          amountFormula: row.numeric.amountFormula,
          flat: row.numeric.flat,
        }
      : null,
    note: row.note ? { note: row.note.note } : null,
    resource: row.resource
      ? {
          resourceId: row.resource.resourceId,
          maxFormula: row.resource.maxFormula,
          fixedMax: row.resource.fixedMax,
          recoverOneOnShort: row.resource.recoverOneOnShort,
          recoverAllOnShort: row.resource.recoverAllOnShort,
          recoverAllOnLong: row.resource.recoverAllOnLong,
          recoverOnLongDice: row.resource.recoverOnLongDice,
        }
      : null,
    combatMod: row.combatMod
      ? {
          modKind: row.combatMod.modKind,
          flatBonus: row.combatMod.flatBonus,
          perLevelBonus: row.combatMod.perLevelBonus,
          fromLevel: row.combatMod.fromLevel,
          secondAbilitySlug: row.combatMod.secondAbilitySlug,
          allowsShield: row.combatMod.allowsShield,
        }
      : null,
    proficiency: row.proficiency
      ? {
          optionKey: row.proficiency.optionKey,
          proficiencyKind: row.proficiency.proficiencyKind,
        }
      : null,
    purchaseDiscount: row.purchaseDiscount
      ? {
          percentOff: row.purchaseDiscount.percentOff,
          nonMagicOnly: row.purchaseDiscount.nonMagicOnly,
          foodDrinkOnly: Boolean(row.purchaseDiscount.foodDrinkOnly),
        }
      : null,
    damageDie: row.damageDie
      ? {
          appliesTo: row.damageDie.appliesTo,
          die: row.damageDie.die,
        }
      : null,
    weapon: row.weapon
      ? {
          propertySlug: row.weapon.propertySlug,
          rangeNormalFt: row.weapon.rangeNormalFt,
          rangeLongFt: row.weapon.rangeLongFt,
        }
      : null,
    feat: row.feat
      ? {
          optionKey: row.feat.optionKey,
          featCategory: row.feat.featCategory,
        }
      : null,
    saveAdvantage: row.saveAdvantage
      ? {
          conditionSlug: row.saveAdvantage.conditionSlug,
          abilitySlugs: row.saveAdvantage.abilitySlugs,
        }
      : null,
    sense: row.sense
      ? {
          senseSlug: row.sense.senseSlug,
          rangeFt: row.sense.rangeFt,
          durationMinutes: row.sense.durationMinutes,
        }
      : null,
    damageType: row.damageType
      ? {
          damageTypeSlug: row.damageType.damageTypeSlug,
          optionKey: row.damageType.optionKey,
        }
      : null,
    language: row.language
      ? {
          optionKey: row.language.optionKey,
          languageSlug: row.language.languageSlug,
          choiceCount: row.language.choiceCount,
        }
      : null,
    checkAdvantage: row.checkAdvantage
      ? {
          skillSlug: row.checkAdvantage.skillSlug,
          circumstanceTag: row.checkAdvantage.circumstanceTag,
          abilitySlug: row.checkAdvantage.abilitySlug,
        }
      : null,
    reach: row.reach
      ? {
          bonusFt: row.reach.bonusFt,
          excludePropertySlugs: row.reach.excludePropertySlugs,
        }
      : null,
    restQuirk: row.restQuirk
      ? {
          longRestHours: row.restQuirk.longRestHours,
          noSleep: row.restQuirk.noSleep,
          noFoodDrinkAir: row.restQuirk.noFoodDrinkAir,
          magicCannotForceSleep: row.restQuirk.magicCannotForceSleep,
        }
      : null,
    environmentalImmunity: row.environmentalImmunity
      ? {
          hazardSlug: row.environmentalImmunity.hazardSlug,
        }
      : null,
    condition: row.condition
      ? {
          conditionSlug: row.condition.conditionSlug,
          pendingKind: row.condition.pendingKind,
        }
      : null,
    save: row.save
      ? {
          saveAbility: row.save.saveAbility,
          dcAbility: row.save.dcAbility,
          dcFormula: row.save.dcFormula,
        }
      : null,
    forcedMovement: row.forcedMovement
      ? {
          distanceM: row.forcedMovement.distanceM,
          maxTargetSize: row.forcedMovement.maxTargetSize,
        }
      : null,
    dice: row.dice
      ? {
          die: row.dice.die,
          dieAtLevel: row.dice.dieAtLevel,
          atLevel: row.dice.atLevel,
          damageTypeSlug: row.dice.damageTypeSlug,
        }
      : null,
    combatFlag: row.combatFlag
      ? {
          flag: row.combatFlag.flag,
          spendOnEnter: Boolean(row.combatFlag.spendOnEnter),
          forceEnter: Boolean(row.combatFlag.forceEnter),
        }
      : null,
    companion: row.companion
      ? {
          restoreHp: Boolean(row.companion.restoreHp),
        }
      : null,
  };
}
